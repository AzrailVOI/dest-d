module dest.decorators.websocket;

/// WebSocket декораторы

/// WebSocket Gateway
struct WebSocketGateway
{
    int port;
    string path;
}

/// WebSocket подписка на событие
struct SubscribeMessage
{
    string event;
}


