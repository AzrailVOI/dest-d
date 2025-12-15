module dest.common.http_status;

/// HTTP статус коды
enum HttpStatus
{
    // 2xx Success
    OK = 200,
    CREATED = 201,
    ACCEPTED = 202,
    NO_CONTENT = 204,
    RESET_CONTENT = 205,
    
    // 3xx Redirection
    MOVED_PERMANENTLY = 301,
    FOUND = 302,
    SEE_OTHER = 303,
    NOT_MODIFIED = 304,
    TEMPORARY_REDIRECT = 307,
    PERMANENT_REDIRECT = 308,
    
    // 4xx Client Error
    BAD_REQUEST = 400,
    UNAUTHORIZED = 401,
    PAYMENT_REQUIRED = 402,
    FORBIDDEN = 403,
    NOT_FOUND = 404,
    METHOD_NOT_ALLOWED = 405,
    NOT_ACCEPTABLE = 406,
    PROXY_AUTHENTICATION_REQUIRED = 407,
    REQUEST_TIMEOUT = 408,
    CONFLICT = 409,
    GONE = 410,
    LENGTH_REQUIRED = 411,
    PRECONDITION_FAILED = 412,
    PAYLOAD_TOO_LARGE = 413,
    URI_TOO_LONG = 414,
    UNSUPPORTED_MEDIA_TYPE = 415,
    RANGE_NOT_SATISFIABLE = 416,
    EXPECTATION_FAILED = 417,
    I_AM_A_TEAPOT = 418,
    UNPROCESSABLE_ENTITY = 422,
    TOO_MANY_REQUESTS = 429,
    
    // 5xx Server Error
    INTERNAL_SERVER_ERROR = 500,
    NOT_IMPLEMENTED = 501,
    BAD_GATEWAY = 502,
    SERVICE_UNAVAILABLE = 503,
    GATEWAY_TIMEOUT = 504,
    HTTP_VERSION_NOT_SUPPORTED = 505,
}

/// Возвращает текст для HTTP статус кода
string getStatusText(HttpStatus status)
{
    switch (status)
    {
        case HttpStatus.OK: return "OK";
        case HttpStatus.CREATED: return "Created";
        case HttpStatus.ACCEPTED: return "Accepted";
        case HttpStatus.NO_CONTENT: return "No Content";
        case HttpStatus.BAD_REQUEST: return "Bad Request";
        case HttpStatus.UNAUTHORIZED: return "Unauthorized";
        case HttpStatus.FORBIDDEN: return "Forbidden";
        case HttpStatus.NOT_FOUND: return "Not Found";
        case HttpStatus.CONFLICT: return "Conflict";
        case HttpStatus.INTERNAL_SERVER_ERROR: return "Internal Server Error";
        case HttpStatus.NOT_IMPLEMENTED: return "Not Implemented";
        case HttpStatus.SERVICE_UNAVAILABLE: return "Service Unavailable";
        default: return "Unknown";
    }
}


