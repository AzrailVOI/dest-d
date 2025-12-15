module dest.http.response.response_core;

import vibe.vibe;
import dest.common.http_status;
import dest.http.response.json_response;
import dest.http.response.text_response;
import dest.http.response.error_handler;
import dest.common.exceptions;

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
    
    /// Отправляет JSON ответ
    void json(Json data) { JsonResponse.json(this, data); }
    void json(string data) { JsonResponse.json(this, data); }
    void json(T)(T data) { JsonResponse.json(this, data); }
    
    /// Отправляет текст
    void send(string text) { TextResponse.send(this, text); }
    
    /// Отправляет пустой ответ
    void end() { TextResponse.end(this); }
    
    /// Обрабатывает HTTP исключение
    void handleException(HttpException exception) { ErrorHandler.handleException(this, exception); }
    
    /// Отправляет ошибку
    void error(int statusCode, string message) { ErrorHandler.error(this, statusCode, message); }
    void error(HttpStatus status, string message) { ErrorHandler.error(this, status, message); }
}

