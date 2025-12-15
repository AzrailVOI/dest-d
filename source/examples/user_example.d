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
    void findAll(Request req, Response res)
    {
        auto users = userService.findAll();
        res.json(users);
    }
    
    @Get("/:id")
    void findOne(Request req, Response res)
    {
        auto id = req["id"];
        auto user = userService.findOne(id);
        res.json(user);
    }
    
    @Post("")
    @HttpCode(201)
    void create(Request req, Response res)
    {
        auto body = req.getBody();
        auto user = userService.create(body);
        res.status(201).json(user);
    }
    
    @Put("/:id")
    void update(Request req, Response res)
    {
        auto id = req["id"];
        auto body = req.getBody();
        auto user = userService.update(id, body);
        res.json(user);
    }
    
    @Delete("/:id")
    @HttpCode(204)
    void remove(Request req, Response res)
    {
        auto id = req["id"];
        userService.remove(id);
        res.status(204).end();
    }
}

/// Сервис пользователей
@Injectable
class UserService
{
    Json findAll()
    {
        Json response = Json.emptyArray;
        response ~= Json(["id": Json(1), "name": Json("John Doe"), "email": Json("john@example.com")]);
        response ~= Json(["id": Json(2), "name": Json("Jane Smith"), "email": Json("jane@example.com")]);
        return response;
    }
    
    Json findOne(string id)
    {
        Json response = Json.emptyObject;
        response["id"] = id;
        response["name"] = "User " ~ id;
        response["email"] = "user" ~ id ~ "@example.com";
        return response;
    }
    
    Json create(Json data)
    {
        Json response = data.clone();
        response["id"] = 3;
        response["createdAt"] = Clock.currTime.toISOExtString();
        return response;
    }
    
    Json update(string id, Json data)
    {
        Json response = data.clone();
        response["id"] = id;
        response["updatedAt"] = Clock.currTime.toISOExtString();
        return response;
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
    
    override void registerRoutes(Router router)
    {
        // Регистрируем контроллер через абстракцию Router
        router.registerController(userController);
        
        logInfo("✓ UserModule routes registered");
    }
}

