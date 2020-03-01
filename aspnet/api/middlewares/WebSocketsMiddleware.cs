namespace toro.middlewares
{
    using System.Net.WebSockets;
    using Microsoft.AspNetCore.Builder;
    using toro.handlers;

    public static class WebSocketsMiddleware
    {
        public static void UseWebSocketsMiddleware(this IApplicationBuilder app)
        {
            app.Use(async (context, next) =>
            {
                if (context.WebSockets.IsWebSocketRequest)
                {
                    WebSocket webSocket = await context.WebSockets.AcceptWebSocketAsync();
                    await WebSocketHandler.Handle(webSocket);
                }
                else
                {
                    await next();
                }

            });
        }
    }
}