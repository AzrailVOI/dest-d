module templates.websocket.gateway;

/// Шаблон WebSocket Gateway
immutable string GATEWAY_TEMPLATE = q{
module %s.%s.gateway;

import vibe.vibe;

/// WebSocket Gateway %s
class %sGateway
{
    private WebSocket[] clients;
    
    this()
    {
        clients = [];
    }
    
    /// Обрабатывает новое WebSocket подключение
    void handleConnection(scope WebSocket sock)
    {
        logInfo("Gateway %%s: новое подключение");
        clients ~= sock;
        
        try
        {
            while (sock.waitForData())
            {
                auto message = sock.receiveText();
                logInfo("Получено сообщение: %%%%s", message);
                
                // Обработка сообщения
                handleMessage(sock, message);
            }
        }
        catch (Exception e)
        {
            logError("Ошибка в Gateway: %%%%s", e.msg);
        }
        finally
        {
            // Удаляем клиента из списка
            import std.algorithm : remove;
            clients = clients.remove!((c) => c is sock);
        }
    }
    
    /// Обрабатывает входящее сообщение
    void handleMessage(scope WebSocket sock, string message)
    {
        // TODO: Реализовать логику обработки сообщений
        
        // Эхо-ответ
        sock.send(message);
    }
    
    /// Отправляет сообщение всем подключенным клиентам
    void broadcast(string message)
    {
        foreach (client; clients)
        {
            try
            {
                client.send(message);
            }
            catch (Exception e)
            {
                logError("Ошибка отправки: %%%%s", e.msg);
            }
        }
    }
}
};


