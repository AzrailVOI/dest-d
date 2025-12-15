module dest.http.request;

import std.conv : to;
import vibe.vibe;

/// Высокоуровневая абстракция HTTP запроса
/// Скрывает детали реализации vibe.d
class Request
{
    private HTTPServerRequest _req;
    
    this(HTTPServerRequest req)
    {
        this._req = req;
    }
    
    /// Параметры из пути (/:id)
    string opIndex(string key)
    {
        return _req.params.get(key, "");
    }
    
    /// Параметры из пути (альтернативный синтаксис)
    string param(string key)
    {
        return _req.params.get(key, "");
    }
    
    /// Параметры из query string (?name=value)
    string getQuery(string key)
    {
        return _req.query.get(key, "");
    }
    
    /// Заголовки запроса
    string getHeader(string name)
    {
        return _req.headers.get(name, "");
    }
    
    /// Тело запроса как JSON
    Json getBody()
    {
        try
        {
            return _req.json;
        }
        catch (Exception)
        {
            return Json.emptyObject;
        }
    }
    
    /// Тело запроса как строка
    string getBodyString()
    {
        try
        {
            return _req.bodyReader.readAllUTF8();
        }
        catch (Exception)
        {
            return "";
        }
    }
    
    /// HTTP метод
    string method()
    {
        return to!string(_req.method);
    }
    
    /// URL запроса
    string url()
    {
        return _req.requestURL;
    }
    
    /// IP адрес клиента
    string ip()
    {
        return _req.clientAddress.toString();
    }
    
    /// Получить внутренний объект запроса (для расширенного использования)
    HTTPServerRequest getRawRequest()
    {
        return _req;
    }
}

