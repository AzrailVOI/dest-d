module generators.template_type;

/// Типы шаблонов для генерации
enum TemplateType
{
    CRUD,
    EMPTY
}

/// Типы компонентов для генерации (по аналогии с NestJS CLI)
enum ComponentType
{
    MODULE,      // module (mo)
    CONTROLLER,  // controller (co)
    SERVICE,     // service (s)
    MIDDLEWARE,  // middleware (mi)
    GUARD,       // guard (gu)
    INTERCEPTOR, // interceptor (in)
    FILTER,      // filter (f)
    PIPE,        // pipe (pi)
    GATEWAY,     // gateway (ga)
    RESOLVER,    // resolver (r)
    PROVIDER,    // provider (pr)
    CLASS,       // class (cl)
    INTERFACE,   // interface (i)
    DECORATOR,   // decorator (d)
    RESOURCE     // resource (res) - полный REST ресурс
}

/// Конвертирует строку в TemplateType
TemplateType parseTemplateType(string typeStr)
{
    import std.uni : toLower;
    
    switch (typeStr.toLower())
    {
        case "crud":
            return TemplateType.CRUD;
        case "empty":
            return TemplateType.EMPTY;
        default:
            throw new Exception("Неизвестный тип шаблона: " ~ typeStr);
    }
}

/// Конвертирует строку в ComponentType
ComponentType parseComponentType(string typeStr)
{
    import std.uni : toLower;
    
    switch (typeStr.toLower())
    {
        case "module":
        case "mo":
            return ComponentType.MODULE;
        case "controller":
        case "co":
            return ComponentType.CONTROLLER;
        case "service":
        case "s":
            return ComponentType.SERVICE;
        case "middleware":
        case "mi":
            return ComponentType.MIDDLEWARE;
        case "guard":
        case "gu":
            return ComponentType.GUARD;
        case "interceptor":
        case "in":
            return ComponentType.INTERCEPTOR;
        case "filter":
        case "f":
            return ComponentType.FILTER;
        case "pipe":
        case "pi":
            return ComponentType.PIPE;
        case "gateway":
        case "ga":
            return ComponentType.GATEWAY;
        case "resolver":
        case "r":
            return ComponentType.RESOLVER;
        case "provider":
        case "pr":
            return ComponentType.PROVIDER;
        case "class":
        case "cl":
            return ComponentType.CLASS;
        case "interface":
        case "i":
            return ComponentType.INTERFACE;
        case "decorator":
        case "d":
            return ComponentType.DECORATOR;
        case "resource":
        case "res":
            return ComponentType.RESOURCE;
        default:
            throw new Exception("Неизвестный тип компонента: " ~ typeStr);
    }
}

/// Возвращает описание типа компонента
string getComponentDescription(ComponentType type)
{
    final switch (type)
    {
        case ComponentType.MODULE:
            return "Модуль с контроллером и сервисом";
        case ComponentType.CONTROLLER:
            return "Контроллер для обработки HTTP запросов";
        case ComponentType.SERVICE:
            return "Сервис с бизнес-логикой";
        case ComponentType.MIDDLEWARE:
            return "Middleware для обработки запросов";
        case ComponentType.GUARD:
            return "Guard для авторизации";
        case ComponentType.INTERCEPTOR:
            return "Interceptor для модификации запросов/ответов";
        case ComponentType.FILTER:
            return "Filter для обработки исключений";
        case ComponentType.PIPE:
            return "Pipe для валидации данных";
        case ComponentType.GATEWAY:
            return "WebSocket Gateway";
        case ComponentType.RESOLVER:
            return "GraphQL Resolver";
        case ComponentType.PROVIDER:
            return "Провайдер (сервис с DI)";
        case ComponentType.CLASS:
            return "Обычный D класс";
        case ComponentType.INTERFACE:
            return "D интерфейс";
        case ComponentType.DECORATOR:
            return "Декоратор/аннотация";
        case ComponentType.RESOURCE:
            return "Полный REST ресурс (module + controller + service)";
    }
}


