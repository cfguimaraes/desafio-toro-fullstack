using Microsoft.AspNetCore.Builder;

public static class WebSocketMiddleware
{
    public static void UseWebSocketMiddleware(this IApplicationBuilder builder)
    {
        builder.Use(async (context, next) =>
        {
            if (context.WebSockets.IsWebSocketRequest)
            {
                var ws = await context.WebSockets.AcceptWebSocketAsync();
                
            }
        });
    }
}