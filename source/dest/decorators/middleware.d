module dest.decorators.middleware;

/// Декораторы для Guards и Interceptors

/// Применить Guard
struct UseGuards
{
    string[] guards;
}

/// Применить Interceptor
struct UseInterceptors
{
    string[] interceptors;
}

/// Применить Pipe
struct UsePipes
{
    string[] pipes;
}

/// Применить Filter
struct UseFilters
{
    string[] filters;
}

/// Middleware декоратор
struct UseMiddleware
{
    string[] middleware;
}


