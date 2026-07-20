import { corsHeaders } from './cors.ts';

export function successResponse(message: string, statusCode = 200): Response {
  return new Response(JSON.stringify({ success: true, message }), {
    status: statusCode,
    headers: {
      'Content-Type': 'application/json',
      ...corsHeaders,
    },
  });
}

export function errorResponse(message: string, statusCode: number): Response {
  return new Response(JSON.stringify({ success: false, message }), {
    status: statusCode,
    headers: {
      'Content-Type': 'application/json',
      ...corsHeaders,
    },
  });
}
