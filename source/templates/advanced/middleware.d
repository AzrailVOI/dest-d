module templates.advanced.middleware;

/// Шаблон middleware
immutable string MIDDLEWARE_TEMPLATE = q{
module %s.%s.middleware;

import dest.http;

/// Middleware для обработки запросов
class %sMiddleware
{
    /// Обрабатывает запрос перед передачей в контроллер
    void handleRequest(Request req, Response res)
    {
        import std.stdio;
        // TODO: Добавить логику обработки запроса
        writeln("Middleware %s: обработка запроса ", req.url());
        
        // Пример: добавление заголовков
        res.header("X-Custom-Header", "Processed by %s");
    }
    
    /// Обрабатывает ответ после контроллера
    void handleResponse(Request req, Response res)
    {
        import std.stdio;
        // TODO: Добавить логику обработки ответа
        writeln("Middleware %s: обработка ответа");
    }
}
};


