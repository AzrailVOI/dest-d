module templates.advanced.filter;

/// Шаблон filter (обработка исключений)
immutable string FILTER_TEMPLATE = q{
module %s.%s.filter;

import dest.http;
import dest.common.exceptions;
import std.datetime;

/// Filter для обработки исключений
class %sFilter
{
    /// Обрабатывает исключение
    void handleException(Exception exception, Request req, Response res)
    {
        import std.stdio;
        stderr.writeln("Filter %s: обработка исключения: ", exception.msg);
        
        // Формируем JSON ответ с ошибкой
        Json errorResponse = Json.emptyObject;
        errorResponse["error"] = exception.msg;
        errorResponse["statusCode"] = 500;
        errorResponse["timestamp"] = Clock.currTime.toISOExtString();
        errorResponse["path"] = req.url();
        
        res.status(500).json(errorResponse.toString());
    }
}
};


