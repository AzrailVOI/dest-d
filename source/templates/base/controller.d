module templates.base.controller;

/// Шаблон контроллера в Dest.d стиле
immutable string DESTD_CONTROLLER_TEMPLATE = q{
module %s.%s.controller;

import dest.decorators;
import dest.http;
import %s.%s.service;

@Controller("/%s")
class %sController
{
    private %sService %sService;
    
    this(%sService service)
    {
        this.%sService = service;
    }
    
    @Get("")
    void findAll(Request req, Response res)
    {
        auto result = %sService.findAll();
        res.json(result);
    }
    
    @Get("/:id")
    void findOne(Request req, Response res)
    {
        auto id = req["id"];
        auto result = %sService.findOne(id);
        res.json(result);
    }
    
    @Post("")
    @HttpCode(201)
    void create(Request req, Response res)
    {
        auto body = req.getBody();
        auto result = %sService.create(body);
        res.status(201).json(result);
    }
    
    @Put("/:id")
    void update(Request req, Response res)
    {
        auto id = req["id"];
        auto body = req.getBody();
        auto result = %sService.update(id, body);
        res.json(result);
    }
    
    @Delete("/:id")
    @HttpCode(204)
    void remove(Request req, Response res)
    {
        auto id = req["id"];
        %sService.remove(id);
        res.status(204).end();
    }
}
};

