export interface CaptchaConfig {
  enabled: boolean;
  provider: 'cloudflare-turnstile' | 'google-recaptcha-v3' | 'none';
  secretKey: string | undefined;
}

export interface CaptchaResult {
  valid: boolean;
  error?: string;
}

export function getCaptchaConfig(): CaptchaConfig {
  const enabled = Deno.env.get('CAPTCHA_ENABLED') === 'true';
  const providerRaw = Deno.env.get('CAPTCHA_PROVIDER') || 'none';
  
  let provider: 'cloudflare-turnstile' | 'google-recaptcha-v3' | 'none' = 'none';
  if (providerRaw === 'cloudflare-turnstile' || providerRaw === 'google-recaptcha-v3') {
    provider = providerRaw as 'cloudflare-turnstile' | 'google-recaptcha-v3';
  }
  
  const secretKey = Deno.env.get('CAPTCHA_SECRET_KEY');
  
  return { enabled, provider, secretKey };
}

export async function verifyCaptcha(token: string | undefined, config: CaptchaConfig): Promise<CaptchaResult> {
  if (!config.enabled) {
    return { valid: true };
  }
  
  if (!token) {
    return { valid: false, error: 'Captcha token required' };
  }
  
  try {
    if (config.provider === 'cloudflare-turnstile') {
      const res = await fetch('https://challenges.cloudflare.com/turnstile/v0/siteverify', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          secret: config.secretKey,
          response: token,
        }),
      });
      const data = await res.json();
      if (!data.success) {
        return { valid: false, error: 'Captcha verification failed' };
      }
      return { valid: true };
    } else if (config.provider === 'google-recaptcha-v3') {
      const res = await fetch('https://www.google.com/recaptcha/api/siteverify', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `secret=${encodeURIComponent(config.secretKey || '')}&response=${encodeURIComponent(token)}`,
      });
      const data = await res.json();
      if (!data.success) {
        return { valid: false, error: 'Captcha verification failed' };
      }
      return { valid: true };
    }
    
    return { valid: false, error: 'Invalid captcha provider configured' };
  } catch (e) {
    const errorMsg = e instanceof Error ? e.message : 'Unknown error';
    console.error('Captcha verification error:', errorMsg);
    return { valid: false, error: 'Captcha verification failed' };
  }
}
