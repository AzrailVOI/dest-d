module templates.advanced.interceptor;

/// Шаблон interceptor
immutable string INTERCEPTOR_TEMPLATE = q{
module %s.%s.interceptor;

import dest.http;
import std.datetime.stopwatch : StopWatch;

/// Interceptor для модификации запросов/ответов
class %sInterceptor
{
    /// Вызывается перед обработкой запроса
    void beforeHandle(Request req, Response res)
    {
        import std.stdio;
        // TODO: Логика перед обработкой
        writeln("Interceptor %s: до обработки");
        
        // Пример: запуск таймера
        // req.context["startTime"] = StopWatch.init;
    }
    
    /// Вызывается после обработки запроса
    void afterHandle(Request req, Response res)
    {
        import std.stdio;
        // TODO: Логика после обработки
        writeln("Interceptor %s: после обработки");
        
        // Пример: логирование времени выполнения
        // auto sw = req.context.get!StopWatch("startTime");
        // writeln("Время выполнения: ", sw.peek.total!"msecs", " ms");
    }
}
};


