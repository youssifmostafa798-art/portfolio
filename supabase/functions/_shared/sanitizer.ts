export function sanitizeString(input: string): string {
  if (!input) return '';
  return input
    .replace(/<[^>]*>/g, '')
    .replace(/\s+/g, ' ')
    .trim();
}

export interface ContactPayload {
  name: string;
  email: string;
  phone?: string;
  message: string;
}

export interface SanitizedContactPayload {
  name: string;
  email: string;
  phone?: string;
  message: string;
}

export function sanitizeContactPayload(payload: ContactPayload): SanitizedContactPayload {
  return {
    name: sanitizeString(payload.name),
    email: sanitizeString(payload.email),
    phone: payload.phone ? sanitizeString(payload.phone) : undefined,
    message: sanitizeString(payload.message),
  };
}
