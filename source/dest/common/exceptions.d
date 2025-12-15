module dest.common.exceptions;

import std.exception;

/// Базовое исключение HTTP для Dest.d
class HttpException : Exception
{
    int statusCode;
    
    this(string msg, int statusCode = 500, Throwable next = null)
    {
        super(msg, next);
        this.statusCode = statusCode;
    }
}

/// Исключение "Не найдено" (404)
class NotFoundException : HttpException
{
    this(string msg = "Resource not found", Throwable next = null)
    {
        super(msg, 404, next);
    }
}

/// Исключение "Не авторизован" (401)
class UnauthorizedException : HttpException
{
    this(string msg = "Unauthorized", Throwable next = null)
    {
        super(msg, 401, next);
    }
}

/// Исключение "Запрещено" (403)
class ForbiddenException : HttpException
{
    this(string msg = "Forbidden", Throwable next = null)
    {
        super(msg, 403, next);
    }
}

/// Исключение "Плохой запрос" (400)
class BadRequestException : HttpException
{
    this(string msg = "Bad Request", Throwable next = null)
    {
        super(msg, 400, next);
    }
}

/// Исключение "Конфликт" (409)
class ConflictException : HttpException
{
    this(string msg = "Conflict", Throwable next = null)
    {
        super(msg, 409, next);
    }
}

/// Исключение "Внутренняя ошибка сервера" (500)
class InternalServerErrorException : HttpException
{
    this(string msg = "Internal Server Error", Throwable next = null)
    {
        super(msg, 500, next);
    }
}

/// Исключение "Не реализовано" (501)
class NotImplementedException : HttpException
{
    this(string msg = "Not Implemented", Throwable next = null)
    {
        super(msg, 501, next);
    }
}

/// Исключение "Недоступен" (503)
class ServiceUnavailableException : HttpException
{
    this(string msg = "Service Unavailable", Throwable next = null)
    {
        super(msg, 503, next);
    }
}


