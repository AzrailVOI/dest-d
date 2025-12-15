module dest.http.response.error_handler;

import vibe.vibe;
import dest.common.exceptions;
import dest.common.http_status;
import vibe.vibe;
import dest.common.exceptions;
import dest.common.http_status;
import dest.http.response.response_core;
import dest.http.response.json_response;

/// Обработка ошибок
class ErrorHandler
{
    static void handleException(Response res, HttpException exception)
    {
        import std.conv : to;
        res.status(exception.statusCode);
        res.header("Content-Type", "application/json; charset=UTF-8");
        
        Json errorResponse = Json.emptyObject;
        errorResponse["statusCode"] = exception.statusCode;
        errorResponse["message"] = exception.msg;
        errorResponse["error"] = getStatusText(cast(HttpStatus)exception.statusCode);
        
        JsonResponse.json(res, errorResponse.toString());
    }
    
    static void error(Response res, int statusCode, string message)
    {
        res.status(statusCode);
        res.header("Content-Type", "application/json; charset=UTF-8");
        
        Json errorResponse = Json.emptyObject;
        errorResponse["statusCode"] = statusCode;
        errorResponse["message"] = message;
        errorResponse["error"] = getStatusText(cast(HttpStatus)statusCode);
        
        JsonResponse.json(res, errorResponse.toString());
    }
    
    static void error(Response res, HttpStatus status, string message)
    {
        error(res, cast(int)status, message);
    }
}

