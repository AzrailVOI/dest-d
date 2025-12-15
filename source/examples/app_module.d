module examples.app_module;

import vibe.vibe;
import dest;
import examples.user_example;

/// Корневой модуль приложения
class AppModule : DestModule
{
    private UserModule userModule;
    
    this()
    {
        super();
        
        // Импортируем другие модули
        userModule = new UserModule();
        userModule.registerModule();
        
        // Метаданные
        metadata.moduleName = "AppModule";
        metadata.imports = ["UserModule"];
    }
    
    override void registerRoutes(URLRouter router)
    {
        // Регистрируем маршруты импортированных модулей
        userModule.registerRoutes(router);
        
        // Корневой маршрут
        router.get("/", (HTTPServerRequest req, HTTPServerResponse res) {
            res.headers["Content-Type"] = "application/json; charset=UTF-8";
            Json response = Json.emptyObject;
            response["message"] = "Welcome to Dest.d API";
            response["version"] = DESTD_VERSION;
            response["endpoints"] = Json.emptyArray;
            response["endpoints"] ~= "/health";
            response["endpoints"] ~= "/users";
            res.writeBody(response.toString());
        });
        
        logInfo("✓ AppModule routes registered");
    }
}

