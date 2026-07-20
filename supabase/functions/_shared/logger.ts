export interface RequestLogContext {
  requestId: string;
  method: string;
  path: string;
  clientIp: string;
  userAgent: string;
  timestamp: string;
}

export function createRequestContext(req: Request): RequestLogContext {
  const requestId = crypto.randomUUID();
  const clientIp = 
    req.headers.get('x-forwarded-for') ||
    req.headers.get('x-real-ip') ||
    req.headers.get('cf-connecting-ip') ||
    'unknown';
  const userAgent = req.headers.get('user-agent') || 'unknown';
  const timestamp = new Date().toISOString();

  const url = new URL(req.url);
  const path = url.pathname;

  return {
    requestId,
    method: req.method,
    path,
    clientIp,
    userAgent,
    timestamp,
  };
}

export function logRequest(ctx: RequestLogContext): void {
  console.log(JSON.stringify({
    event: 'request_started',
    requestId: ctx.requestId,
    method: ctx.method,
    clientIp: ctx.clientIp,
    timestamp: ctx.timestamp,
  }));
}

export function logResponse(ctx: RequestLogContext, status: number, durationMs: number): void {
  console.log(JSON.stringify({
    event: 'request_completed',
    requestId: ctx.requestId,
    status,
    durationMs,
    timestamp: new Date().toISOString(),
  }));
}

export function logError(ctx: RequestLogContext, error: string): void {
  console.error(JSON.stringify({
    event: 'request_error',
    requestId: ctx.requestId,
    error,
    timestamp: new Date().toISOString(),
  }));
}
