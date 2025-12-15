module dest.decorators.params;

/// Декораторы для параметров запросов

/// Параметр из тела запроса
struct Body
{
    string key;
}

/// Параметр из пути
struct Param
{
    string name;
}

/// Параметр из query string
struct Query
{
    string name;
}

/// Заголовок запроса
struct Header
{
    string name;
}

/// Весь объект запроса
struct Req { }

/// Весь объект ответа
struct Res { }


