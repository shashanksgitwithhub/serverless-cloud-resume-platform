const ALLOWED_ORIGINS = [
  "https://shashanktj.com",
  "https://www.shashanktj.com"
];

export default {
  async fetch(request, env) {
    const origin = request.headers.get("Origin");

    const corsHeaders = {
      "Access-Control-Allow-Origin": ALLOWED_ORIGINS.includes(origin)
        ? origin
        : "https://shashanktj.com",
      "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
      "Access-Control-Allow-Headers": "Content-Type",
      "Content-Type": "application/json"
    };

    // Handle browser preflight requests
    if (request.method === "OPTIONS") {
      return new Response(null, {
        status: 204,
        headers: corsHeaders
      });
    }

    const url = new URL(request.url);

    if (url.pathname !== "/visitors") {
      return Response.json(
        { error: "Not Found" },
        { status: 404, headers: corsHeaders }
      );
    }

    try {
      // Read current visitor count
      let count = Number(
        await env.VISITOR_COUNT.get("total_visitors")
      ) || 0;

      // Increment count for POST requests
      if (request.method === "POST") {
        count++;

        await env.VISITOR_COUNT.put(
          "total_visitors",
          count.toString()
        );
      } else if (request.method !== "GET") {
        return Response.json(
          { error: "Method Not Allowed" },
          { status: 405, headers: corsHeaders }
        );
      }

      return Response.json(
        {
          success: true,
          visitors: count
        },
        {
          status: 200,
          headers: {
            ...corsHeaders,
            "Cache-Control": "no-store"
          }
        }
      );

    } catch (error) {
      return Response.json(
        { error: "Internal Server Error" },
        {
          status: 500,
          headers: corsHeaders
        }
      );
    }
  }
};