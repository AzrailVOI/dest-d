# 🎯 Dest.d

> **NestJS-inspired метафреймворк для vibe.d**

[![DUB](https://img.shields.io/dub/v/dest-d.svg)](https://code.dlang.org/packages/dest-d)
[![D](https://img.shields.io/badge/language-D-red.svg)](https://dlang.org/)
[![Vibe.d](https://img.shields.io/badge/framework-vibe.d-blue.svg)](https://vibed.org/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

Dest.d объединяет производительность **D**, асинхронность **vibe.d** и архитектуру **NestJS** для создания масштабируемых серверных приложений.

## ✨ Особенности

- 🎨 **Декларативный синтаксис** с декораторами `@Controller`, `@Get`, `@Post`, `@Injectable`
- 💉 **Dependency Injection** контейнер с автоматическим разрешением зависимостей
- 📦 **Модульная архитектура** с импортами и экспортами
- 🔄 **Автомаршрутизация** из метаданных декораторов
- ⚡ **Async/Non-blocking** на базе vibe.d
- 🛡️ **Guards, Interceptors, Pipes, Filters** из коробки
- 🌐 **CORS & Global Prefix** поддержка
- 📊 **Type-safe** статическая типизация D

## 🚀 Быстрый старт

### Установка

Добавьте в ваш `dub.json`:

```json
{
    "dependencies": {
        "dest-d": "~>1.0.0"
    }
}
```

### Hello World

```d
import dest;

@Controller("/hello")
class HelloController
{
    @Get("")
    void sayHello(HTTPServerRequest req, HTTPServerResponse res)
    {
        res.writeBody(`{"message": "Hello, Dest.d!"}`, "application/json");
    }
}

class HelloModule : NestModule
{
    private HelloController controller;
    
    this()
    {
        super();
        controller = new HelloController();
    }
    
    override void registerRoutes(URLRouter router)
    {
        auto meta = extractControllerMetadata!HelloController();
        foreach (route; meta.routes)
        {
            router.get(meta.basePath, &controller.sayHello);
        }
    }
}

class AppModule : NestModule
{
    private HelloModule helloModule;
    
    this()
    {
        super();
        helloModule = new HelloModule();
        helloModule.registerModule();
    }
    
    override void registerRoutes(URLRouter router)
    {
        helloModule.registerRoutes(router);
    }
}

void main()
{
    auto app = DestFactory.create(new AppModule(), (ref config) {
        config.port = 3000;
    });
    
    app.listen();
}
```

Запустите:
```bash
dub run
# Откройте http://localhost:3000/hello
```

## 📖 Полный пример

### Контроллер

```d
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
        res.writeBody(userService.findAll(), "application/json");
    }
    
    @Get("/:id")
    void findOne(HTTPServerRequest req, HTTPServerResponse res)
    {
        auto id = req.params["id"];
        res.writeBody(userService.findOne(id), "application/json");
    }
    
    @Post("")
    @HttpCode(201)
    void create(HTTPServerRequest req, HTTPServerResponse res)
    {
        auto user = userService.create(req.json);
        res.statusCode = 201;
        res.writeBody(user, "application/json");
    }
}
```

### Сервис с DI

```d
@Injectable
class UserService
{
    string findAll()
    {
        Json users = Json.emptyArray;
        users ~= Json(["id": 1, "name": "John"]);
        users ~= Json(["id": 2, "name": "Jane"]);
        return users.toString();
    }
    
    string findOne(string id)
    {
        return Json(["id": id, "name": "User"]).toString();
    }
    
    string create(Json data)
    {
        data["id"] = 3;
        return data.toString();
    }
}
```

### Модуль

```d
class UserModule : NestModule
{
    private UserService userService;
    private UserController userController;
    
    this()
    {
        super();
        
        // DI: Регистрируем и создаем инстансы
        container.register!UserService();
        userService = container.resolve!UserService();
        userController = new UserController(userService);
    }
    
    override void registerRoutes(URLRouter router)
    {
        auto meta = extractControllerMetadata!UserController();
        
        // Автоматическая регистрация из метаданных
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
                    router.post(fullPath, &userController.create);
                    break;
                default: break;
            }
        }
    }
}
```

## 🎨 Доступные декораторы

### HTTP методы
- `@Get(path)` - GET запрос
- `@Post(path)` - POST запрос
- `@Put(path)` - PUT запрос
- `@Delete(path)` - DELETE запрос
- `@Patch(path)` - PATCH запрос

### Классы
- `@Controller(path)` - HTTP контроллер
- `@Injectable` - Провайдер для DI

### Параметры
- `@Body()` - Тело запроса
- `@Param(name)` - Параметр из URL
- `@Query(name)` - Query параметр
- `@Header(name)` - HTTP заголовок

### Middleware
- `@UseGuards(...)` - Авторизация
- `@UseInterceptors(...)` - Перехватчики
- `@UsePipes(...)` - Валидация
- `@UseFilters(...)` - Обработка ошибок

### Другие
- `@HttpCode(code)` - HTTP код ответа
- `@WebSocketGateway` - WebSocket gateway

## 🔧 Конфигурация

```d
auto app = DestFactory.create(appModule, (ref config) {
    config.port = 3000;              // Порт (по умолчанию 8080)
    config.host = "0.0.0.0";         // Хост
    config.enableLogging = true;     // Логирование
    config.globalPrefix = "/api";    // Глобальный префикс
    config.enableCors = true;        // CORS
});
```

## 📦 Структура модуля

```d
class MyModule : NestModule
{
    this()
    {
        super();
        
        // 1. Регистрация провайдеров в DI
        container.register!MyService();
        
        // 2. Создание инстансов
        myService = container.resolve!MyService();
        myController = new MyController(myService);
        
        // 3. Метаданные модуля
        metadata.moduleName = "MyModule";
        metadata.providers = ["MyService"];
        metadata.controllers = ["MyController"];
    }
    
    override void registerRoutes(URLRouter router)
    {
        // Автоматическая регистрация маршрутов
    }
}
```

## 🌟 Преимущества

| Dest.d | vibe.d | NestJS |
|--------|--------|--------|
| ✅ Декораторы | ❌ | ✅ |
| ✅ DI контейнер | ❌ | ✅ |
| ✅ Модули | ❌ | ✅ |
| ✅ Автомаршрутизация | ❌ | ✅ |
| ⚡⚡⚡ Производительность | ⚡⚡⚡ | ⚡⚡ |
| ✅ Compile-time метаданные | ❌ | Runtime |
| ✅ Type-safe | ✅ | ✅ |

## 📚 Документация

- 📖 [Полное руководство](DESTD_FRAMEWORK.md)
- 💡 [Примеры использования](DESTD_USAGE.md)
- 🏗️ [Техническая документация](DESTD_IMPLEMENTATION.md)
- 📦 [Структура пакета](DESTD_PACKAGE.md)

## 🛠️ CLI Генератор

Этот репозиторий также включает CLI генератор:

```bash
# Клонируйте репозиторий
git clone https://github.com/yourusername/dest-d.git
cd dest-d
dub build

# Генерируйте модули
./generator nestjs user
./generator g controller products
./generator g service email
```

## 🤝 Вклад

Приветствуются pull requests! Для серьезных изменений сначала откройте issue.

## 📄 Лицензия

MIT

## 🎉 Благодарности

- [NestJS](https://nestjs.com/) - за вдохновение архитектурой
- [vibe.d](https://vibed.org/) - за отличный асинхронный фреймворк
- [D Language](https://dlang.org/) - за производительность и метапрограммирование

---

**Создавайте масштабируемые серверные приложения с удовольствием! 🚀**

Made with ❤️ for the D community


