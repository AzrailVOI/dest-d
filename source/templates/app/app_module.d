module templates.app.app_module;

/// Шаблон AppModule
immutable string DESTD_APP_MODULE_TEMPLATE = q{
module app_module;

import dest.module_system;
%s

/// Корневой модуль приложения
class AppModule : DestModule
{
%s
    
    this()
    {
        super();
        
        // Импортируем модули
%s
        
        // Метаданные
        metadata.moduleName = "AppModule";
        metadata.imports = [%s];
    }
    
    override void registerRoutes(Router router)
    {
        import dest.router;
        // Регистрируем маршруты импортированных модулей
%s
        
        // Корневой маршрут
        router.get("/", (Request req, Response res) {
            import dest.http;
            import dest;
            Json response = Json.emptyObject;
            response["message"] = "Welcome to Dest.d API";
            response["version"] = DESTD_VERSION;
            response["endpoints"] = Json.emptyArray;
            response["endpoints"] ~= "/health";
%s
            res.json(response.toString());
        });
    }
}
};


