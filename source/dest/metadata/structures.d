module dest.metadata.structures;

/// Информация о маршруте
struct RouteMetadata
{
    string method;      // GET, POST, PUT, DELETE, PATCH
    string path;        // путь маршрута
    string handler;     // имя метода-обработчика
}

/// Информация о контроллере
struct ControllerMetadata
{
    string basePath;
    RouteMetadata[] routes;
    string[] guards;
    string[] interceptors;
    string[] middlewares;
}

/// Информация о провайдере
struct ProviderMetadata
{
    string className;
    string scope_;       // singleton, request, transient
    string[] dependencies;
}

/// Информация о модуле
struct ModuleMetadata
{
    string moduleName;
    string[] imports;
    string[] controllers;
    string[] providers;
    string[] exports;
}


