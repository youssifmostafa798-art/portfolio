import { handleCorsPreFlight } from '../_shared/cors.ts';
import { successResponse, errorResponse } from '../_shared/response.ts';
import { createRequestContext, logRequest, logResponse, logError, RequestLogContext } from '../_shared/logger.ts';
import { checkRateLimit } from '../_shared/rate_limiter.ts';
import { sanitizeContactPayload, ContactPayload, SanitizedContactPayload } from '../_shared/sanitizer.ts';
import { getCaptchaConfig, verifyCaptcha } from '../_shared/captcha.ts';

const MAX_PAYLOAD_BYTES = 10_240;
const EMAIL_REGEX = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
const NAME_MAX_LENGTH = 100;
const MESSAGE_MAX_LENGTH = 5000;
const PHONE_MAX_LENGTH = 20;

function validatePayload(payload: ContactPayload): string | null {
  if (!payload.name || payload.name.trim().length === 0) return 'Name is required';
  if (payload.name.length > NAME_MAX_LENGTH) return `Name must be less than ${NAME_MAX_LENGTH} characters`;
  
  if (!payload.email || payload.email.trim().length === 0) return 'Email is required';
  if (!EMAIL_REGEX.test(payload.email.trim())) return 'Invalid email format';
  
  if (!payload.message || payload.message.trim().length === 0) return 'Message is required';
  if (payload.message.length > MESSAGE_MAX_LENGTH) return `Message must be less than ${MESSAGE_MAX_LENGTH} characters`;
  
  if (payload.phone && payload.phone.length > PHONE_MAX_LENGTH) return `Phone must be less than ${PHONE_MAX_LENGTH} characters`;
  
  return null;
}

function buildEmailHtml(payload: SanitizedContactPayload, ctx: RequestLogContext): string {
  return `
    <div style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; background-color: #1C1C1E; color: #F2F2F7; padding: 40px 20px; max-width: 600px; margin: 0 auto; border-radius: 8px;">
      <h2 style="color: #007AFF; margin-bottom: 24px; border-bottom: 1px solid #38383A; padding-bottom: 12px;">New Portfolio Contact</h2>
      
      <table style="width: 100%; border-collapse: collapse; margin-bottom: 32px;">
        <tr>
          <td style="padding: 12px 0; border-bottom: 1px solid #38383A; color: #8E8E93; width: 100px;">Name</td>
          <td style="padding: 12px 0; border-bottom: 1px solid #38383A; color: #F2F2F7;">${payload.name}</td>
        </tr>
        <tr>
          <td style="padding: 12px 0; border-bottom: 1px solid #38383A; color: #8E8E93;">Email</td>
          <td style="padding: 12px 0; border-bottom: 1px solid #38383A; color: #F2F2F7;"><a href="mailto:${payload.email}" style="color: #007AFF; text-decoration: none;">${payload.email}</a></td>
        </tr>
        <tr>
          <td style="padding: 12px 0; border-bottom: 1px solid #38383A; color: #8E8E93;">Phone</td>
          <td style="padding: 12px 0; border-bottom: 1px solid #38383A; color: #F2F2F7;">${payload.phone || 'Not provided'}</td>
        </tr>
      </table>
      
      <div style="background-color: #2C2C2E; padding: 20px; border-radius: 8px; margin-bottom: 32px; white-space: pre-wrap; color: #F2F2F7; line-height: 1.6;">
        ${payload.message}
      </div>
      
      <div style="font-size: 12px; color: #8E8E93; border-top: 1px solid #38383A; padding-top: 16px;">
        <p style="margin: 4px 0;"><strong>Submission Metadata:</strong></p>
        <p style="margin: 4px 0;">Timestamp: ${ctx.timestamp}</p>
        <p style="margin: 4px 0;">Client IP: ${ctx.clientIp}</p>
        <p style="margin: 4px 0;">User-Agent: ${ctx.userAgent}</p>
      </div>
    </div>
  `;
}

async function sendEmail(payload: SanitizedContactPayload, ctx: RequestLogContext): Promise<unknown> {
  const apiKey = Deno.env.get('RESEND_API_KEY');
  const contactEmail = Deno.env.get('CONTACT_EMAIL');
  
  if (!apiKey || !contactEmail) {
    throw new Error('Email configuration missing');
  }
  
  const res = await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${apiKey}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      from: 'Portfolio Contact <onboarding@resend.dev>',
      to: [contactEmail],
      subject: `Portfolio Contact: ${payload.name}`,
      html: buildEmailHtml(payload, ctx),
      reply_to: payload.email,
    }),
  });
  
  if (!res.ok) {
    const errorData = await res.text();
    throw new Error(`Email send failed: ${errorData}`);
  }
  
  return res.json();
}

Deno.serve(async (req: Request) => {
  const startTime = performance.now();
  const ctx = createRequestContext(req);
  let status = 200;
  
  try {
    logRequest(ctx);
    
    const corsPreflightResponse = handleCorsPreFlight(req);
    if (corsPreflightResponse) {
      status = 204;
      return corsPreflightResponse;
    }
    
    if (req.method !== 'POST') {
      status = 405;
      return errorResponse('Method Not Allowed', status);
    }
    
    const rateLimit = checkRateLimit(ctx.clientIp);
    if (!rateLimit.allowed) {
      status = 429;
      const res = errorResponse('Too Many Requests', status);
      if (rateLimit.retryAfterSeconds !== null) {
        res.headers.set('Retry-After', rateLimit.retryAfterSeconds.toString());
      }
      return res;
    }
    
    const contentLength = req.headers.get('content-length');
    if (contentLength && parseInt(contentLength, 10) > MAX_PAYLOAD_BYTES) {
      status = 400;
      return errorResponse('Payload Too Large', status);
    }
    
    let rawPayload: unknown;
    try {
      rawPayload = await req.json();
    } catch {
      status = 400;
      return errorResponse('Invalid JSON payload', status);
    }
    
    const validationError = validatePayload(rawPayload as ContactPayload);
    if (validationError) {
      status = 400;
      return errorResponse(validationError, status);
    }
    
    const captchaConfig = getCaptchaConfig();
    const rawRecord = rawPayload as Record<string, unknown>;
    const captchaResult = await verifyCaptcha(
      typeof rawRecord.captchaToken === 'string' ? rawRecord.captchaToken : undefined,
      captchaConfig,
    );
    if (!captchaResult.valid) {
      status = 403;
      return errorResponse(captchaResult.error || 'Captcha verification failed', status);
    }
    
    const sanitizedPayload = sanitizeContactPayload(rawPayload as ContactPayload);
    
    await sendEmail(sanitizedPayload, ctx);
    
    status = 200;
    return successResponse('Message sent successfully.', status);
    
  } catch (error) {
    const errorMsg = error instanceof Error ? error.message : 'Unknown error';
    logError(ctx, errorMsg);
    status = 500;
    return errorResponse('An unexpected error occurred.', status);
  } finally {
    const durationMs = Math.round(performance.now() - startTime);
    logResponse(ctx, status, durationMs);
  }
});
    