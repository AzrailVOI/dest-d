module examples.user_example;

import vibe.vibe;
import dest;

/// Контроллер пользователей с декораторами
@Controller("/users")
class UserController
{
    private UserService userService;
    
    this(UserService service)
    {
        this.userService = service;
    }
    
    @Get("")
    void findAll(HTTPServerRequest req, HTTPServerResponse res)
    {
        auto users = userService.findAll();
        res.headers["Content-Type"] = "application/json; charset=UTF-8";
        res.writeBody(users);
    }
    
    @Get("/:id")
    void findOne(HTTPServerRequest req, HTTPServerResponse res)
    {
        auto id = req.params["id"];
        auto user = userService.findOne(id);
        res.headers["Content-Type"] = "application/json; charset=UTF-8";
        res.writeBody(user);
    }
    
    @Post("")
    @HttpCode(201)
    void create(HTTPServerRequest req, HTTPServerResponse res)
    {
        auto body = req.json;
        auto user = userService.create(body);
        res.statusCode = 201;
        res.headers["Content-Type"] = "application/json; charset=UTF-8";
        res.writeBody(user);
    }
    
    @Put("/:id")
    void update(HTTPServerRequest req, HTTPServerResponse res)
    {
        auto id = req.params["id"];
        auto body = req.json;
        auto user = userService.update(id, body);
        res.headers["Content-Type"] = "application/json; charset=UTF-8";
        res.writeBody(user);
    }
    
    @Delete("/:id")
    @HttpCode(204)
    void remove(HTTPServerRequest req, HTTPServerResponse res)
    {
        auto id = req.params["id"];
        userService.remove(id);
        res.statusCode = 204;
        res.writeVoidBody();
    }
}

/// Сервис пользователей
@Injectable
class UserService
{
    string findAll()
    {
        Json response = Json.emptyArray;
        response ~= Json(["id": Json(1), "name": Json("John Doe"), "email": Json("john@example.com")]);
        response ~= Json(["id": Json(2), "name": Json("Jane Smith"), "email": Json("jane@example.com")]);
        return response.toString();
    }
    
    string findOne(string id)
    {
        Json response = Json.emptyObject;
        response["id"] = id;
        response["name"] = "User " ~ id;
        response["email"] = "user" ~ id ~ "@example.com";
        return response.toString();
    }
    
    string create(Json data)
    {
        Json response = data.clone();
        response["id"] = 3;
        response["createdAt"] = Clock.currTime.toISOExtString();
        return response.toString();
    }
    
    string update(string id, Json data)
    {
        Json response = data.clone();
        response["id"] = id;
        response["updatedAt"] = Clock.currTime.toISOExtString();
        return response.toString();
    }
    
    void remove(string id)
    {
        // Логика удаления
        logInfo("User %s removed", id);
    }
}

/// Модуль пользователей
class UserModule : DestModule
{
    private UserService userService;
    private UserController userController;
    
    this()
    {
        super();
        
        // Регистрируем провайдеры
        container.register!UserService();
        
        // Создаем инстансы
        userService = container.resolve!UserService();
        userController = new UserController(userService);
        
        // Заполняем метаданные
        metadata.moduleName = "UserModule";
        metadata.controllers = ["UserController"];
        metadata.providers = ["UserService"];
        metadata.exports = ["UserService"];
    }
    
    override void registerRoutes(URLRouter router)
    {
        auto meta = extractControllerMetadata!UserController();
        
        // Регистрируем маршруты из метаданных
        foreach (route; meta.routes)
        {
            string fullPath = meta.basePath ~ route.path;
            
            switch (route.method)
            {
                case "GET":
                    if (route.handler == "findAll")
                        router.get(fullPath, &userController.findAll);
                    else if (route.handler == "findOne")
                        router.get(fullPath, &userController.findOne);
                    break;
                    
                case "POST":
                    if (route.handler == "create")
                        router.post(fullPath, &userController.create);
                    break;
                    
                case "PUT":
                    if (route.handler == "update")
                        router.put(fullPath, &userController.update);
                    break;
                    
                case "DELETE":
                    if (route.handler == "remove")
                        router.delete_(fullPath, &userController.remove);
                    break;
                    
                default:
                    break;
            }
        }
        
        logInfo("✓ UserModule routes registered");
    }
}

