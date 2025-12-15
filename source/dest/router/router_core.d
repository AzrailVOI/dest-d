module dest.router.router_core;

import vibe.vibe;
import dest.http;

/// Класс для упрощенной регистрации маршрутов
class Router
{
    private URLRouter _router;
    
    this(URLRouter router)
    {
        this._router = router;
    }
    
    /// GET запрос
    void get(string path, void delegate(Request, Response) handler)
    {
        _router.get(path, (HTTPServerRequest req, HTTPServerResponse res) {
            handler(new Request(req), new Response(res));
        });
    }
    
    /// POST запрос
    void post(string path, void delegate(Request, Response) handler)
    {
        _router.post(path, (HTTPServerRequest req, HTTPServerResponse res) {
            handler(new Request(req), new Response(res));
        });
    }
    
    /// PUT запрос
    void put(string path, void delegate(Request, Response) handler)
    {
        _router.put(path, (HTTPServerRequest req, HTTPServerResponse res) {
            handler(new Request(req), new Response(res));
        });
    }
    
    /// DELETE запрос
    void delete_(string path, void delegate(Request, Response) handler)
    {
        _router.delete_(path, (HTTPServerRequest req, HTTPServerResponse res) {
            handler(new Request(req), new Response(res));
        });
    }
    
    /// PATCH запрос
    void patch(string path, void delegate(Request, Response) handler)
    {
        _router.patch(path, (HTTPServerRequest req, HTTPServerResponse res) {
            handler(new Request(req), new Response(res));
        });
    }
    
    /// Регистрирует контроллер
    void registerController(T)(T controller)
    {
        import dest.router.controller_registration;
        ControllerRegistrator.registerController(this, controller);
    }
}

