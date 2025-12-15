module dest.http.response;

import vibe.vibe;
import dest.common.exceptions;
import dest.common.http_status;
import dest.http.response.response_core;
import dest.http.response.json_response;
import dest.http.response.text_response;
import dest.http.response.error_handler;

/// HTTP Response абстракции
public import dest.http.response.response_core : Response;

/// Расширение Response с методами через миксин
mixin template ResponseMixin()
{
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

/// Применяем миксин к Response
mixin ResponseMixin!() Response;
