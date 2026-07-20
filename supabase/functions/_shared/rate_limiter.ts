const MAX_REQUESTS = 5;
const WINDOW_MS = 60_000;
const CLEANUP_INTERVAL_MS = 300_000;

const ipTimestamps = new Map<string, number[]>();

export interface RateLimitResult {
  allowed: boolean;
  retryAfterSeconds: number | null;
}

export function checkRateLimit(clientIp: string): RateLimitResult {
  const now = Date.now();
  const timestamps = ipTimestamps.get(clientIp) || [];
  
  const validTimestamps = timestamps.filter(ts => now - ts < WINDOW_MS);
  
  if (validTimestamps.length >= MAX_REQUESTS) {
    const oldestTimestamp = validTimestamps[0];
    const retryAfterSeconds = Math.ceil((oldestTimestamp + WINDOW_MS - now) / 1000);
    return { allowed: false, retryAfterSeconds };
  }
  
  validTimestamps.push(now);
  ipTimestamps.set(clientIp, validTimestamps);
  
  return { allowed: true, retryAfterSeconds: null };
}

setInterval(() => {
  const now = Date.now();
  for (const [ip, timestamps] of ipTimestamps.entries()) {
    const validTimestamps = timestamps.filter(ts => now - ts < WINDOW_MS);
    if (validTimestamps.length === 0) {
      ipTimestamps.delete(ip);
    } else {
      ipTimestamps.set(ip, validTimestamps);
    }
  }
}, CLEANUP_INTERVAL_MS);
