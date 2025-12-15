module dest.http.response.response_core;

import vibe.vibe;
import dest.common.http_status;

/// Высокоуровневая абстракция HTTP ответа
/// Скрывает детали реализации vibe.d
class Response
{
    protected HTTPServerResponse _res;
    
    this(HTTPServerResponse res)
    {
        this._res = res;
    }
    
    /// Устанавливает статус код
    Response status(int code)
    {
        _res.statusCode = code;
        return this;
    }
    
    /// Устанавливает статус код через HttpStatus enum
    Response status(HttpStatus status)
    {
        _res.statusCode = cast(int)status;
        return this;
    }
    
    /// Устанавливает заголовок
    Response header(string name, string value)
    {
        _res.headers[name] = value;
        return this;
    }
    
    /// Получить внутренний объект ответа (для расширенного использования)
    @property HTTPServerResponse raw()
    {
        return _res;
    }
}

