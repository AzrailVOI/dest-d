module dest.decorators.http;

/// HTTP методы - декораторы для маршрутов

/// GET запрос
struct Get
{
    string path;
}

/// POST запрос
struct Post
{
    string path;
}

/// PUT запрос
struct Put
{
    string path;
}

/// DELETE запрос
struct Delete
{
    string path;
}

/// PATCH запрос
struct Patch
{
    string path;
}

/// HTTP коды ответа
struct HttpCode
{
    int code;
}

/// Заголовки ответа
struct SetHeader
{
    string name;
    string value;
}


