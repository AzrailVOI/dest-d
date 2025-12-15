module dest.application.routes;

import vibe.vibe;
import dest.application.config;
import dest.router;
import dest.module_system;

/// Настройка маршрутов
class RouteConfigurator
{
    static void setupHealthCheck(URLRouter router)
    {
        router.get("/health", (HTTPServerRequest req, HTTPServerResponse res) {
            res.headers["Content-Type"] = "application/json; charset=UTF-8";
            Json response = Json.emptyObject;
            response["status"] = "ok";
            response["timestamp"] = Clock.currTime.toISOExtString();
            res.writeBody(response.toString());
        });
    }
    
    static void setupCors(URLRouter router, ApplicationConfig config)
    {
        if (!config.enableCors) return;
        
        router.any("*", (HTTPServerRequest req, HTTPServerResponse res) {
            res.headers["Access-Control-Allow-Origin"] = "*";
            res.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, PATCH, OPTIONS";
            res.headers["Access-Control-Allow-Headers"] = "Content-Type, Authorization";
            
            if (req.method == HTTPMethod.OPTIONS)
            {
                res.statusCode = 204;
                res.writeVoidBody();
            }
        });
    }
    
    static void setupGlobalPrefix(URLRouter router, ApplicationConfig config, ModuleManager moduleManager)
    {
        if (config.globalPrefix.length == 0) return;
        
        auto prefixedRouter = new URLRouter(config.globalPrefix);
        Router prefixedDestRouter = new Router(prefixedRouter);
        moduleManager.registerAllRoutes(prefixedDestRouter);
        router.any(config.globalPrefix ~ "/*", prefixedRouter);
    }
}


