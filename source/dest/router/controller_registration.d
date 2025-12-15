module dest.router.controller_registration;

import std.traits;
import dest.http;
import dest.metadata;
import dest.router.router_core;

/// Регистрация контроллеров
class ControllerRegistrator
{
    static void registerController(Router router, T)(T controller)
    {
        auto meta = extractControllerMetadata!T();
        string basePath = meta.basePath.length > 0 ? meta.basePath : "";
        
        foreach (route; meta.routes)
        {
            string fullPath = basePath ~ route.path;
            auto handler = getHandler!(T, route.handler)(controller);
            
            switch (route.method)
            {
                case "GET":
                    router.get(fullPath, handler);
                    break;
                case "POST":
                    router.post(fullPath, handler);
                    break;
                case "PUT":
                    router.put(fullPath, handler);
                    break;
                case "DELETE":
                    router.delete_(fullPath, handler);
                    break;
                case "PATCH":
                    router.patch(fullPath, handler);
                    break;
                default:
                    break;
            }
        }
    }
    
    private static void delegate(Request, Response) getHandler(T, string methodName)(T controller)
    {
        // Создаем делегат, вызывая метод контроллера
        // Метод должен иметь сигнатуру void method(Request, Response)
        return (Request req, Response res) {
            __traits(getMember, controller, methodName)(req, res);
        };
    }
}


