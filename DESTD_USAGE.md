# 📦 Использование Dest.d как библиотеки

## 🚀 Установка

### Вариант 1: Локальная зависимость

Добавьте в ваш `dub.json`:

```json
{
    "name": "my-awesome-app",
    "dependencies": {
        "dest-d": {"path": "../путь/к/dest-d"}
    }
}
```

### Вариант 2: Через DUB registry (после публикации)

```json
{
    "name": "my-awesome-app",
    "dependencies": {
        "dest-d": "~>1.0.0"
    }
}
```

## 💡 Использование

### 1. Импорт фреймворка

```d
import dest;  // Импортирует весь фреймворк
```

Или выборочно:

```d
import dest.decorators;    // Только декораторы
import dest.di_container;  // Только DI контейнер
import dest.module_system; // Только систему модулей
import dest.application;   // Только приложение
```

### 2. Создание контроллера

```d
module myapp.user.controller;

import vibe.vibe;
import dest;

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
        res.writeBody(users, "application/json");
    }
    
    @Post("")
    @HttpCode(201)
    void create(HTTPServerRequest req, HTTPServerResponse res)
    {
        auto body = req.json;
        auto user = userService.create(body);
        res.statusCode = 201;
        res.writeBody(user, "application/json");
    }
}
```

### 3. Создание сервиса

```d
module myapp.user.service;

import vibe.vibe;
import dest;

@Injectable
class UserService
{
    string findAll()
    {
        Json users = Json.emptyArray;
        users ~= Json(["id": 1, "name": "John"]);
        return users.toString();
    }
    
    string create(Json data)
    {
        // Логика создания
        return data.toString();
    }
}
```

### 4. Создание модуля

```d
module myapp.user.module;

import vibe.vibe;
import dest;
import myapp.user.controller;
import myapp.user.service;

class UserModule : NestModule
{
    private UserService userService;
    private UserController userController;
    
    this()
    {
        super();
        
        // Регистрируем в DI
        container.register!UserService();
        
        // Создаем инстансы
        userService = container.resolve!UserService();
        userController = new UserController(userService);
        
        // Метаданные
        metadata.moduleName = "UserModule";
        metadata.providers = ["UserService"];
        metadata.controllers = ["UserController"];
    }
    
    override void registerRoutes(URLRouter router)
    {
        auto meta = extractControllerMetadata!UserController();
        
        // Регистрируем маршруты
        foreach (route; meta.routes)
        {
            string fullPath = meta.basePath ~ route.path;
            
            switch (route.method)
            {
                case "GET":
                    if (route.handler == "findAll")
                        router.get(fullPath, &userController.findAll);
                    break;
                case "POST":
                    if (route.handler == "create")
                        router.post(fullPath, &userController.create);
                    break;
                default: break;
            }
        }
    }
}
```

### 5. Корневой модуль

```d
module app_module;

import vibe.vibe;
import dest;
import myapp.user.module;

class AppModule : NestModule
{
    private UserModule userModule;
    
    this()
    {
        super();
        
        userModule = new UserModule();
        userModule.registerModule();
        
        metadata.moduleName = "AppModule";
        metadata.imports = ["UserModule"];
    }
    
    override void registerRoutes(URLRouter router)
    {
        userModule.registerRoutes(router);
        
        router.get("/", (req, res) {
            res.writeBody(`{"message": "Welcome to Dest.d API"}`, "application/json");
        });
    }
}
```

### 6. Точка входа

```d
module app;

import dest;
import app_module;

void main()
{
    printFrameworkInfo();
    
    auto appModule = new AppModule();
    
    auto app = DestFactory.create(appModule, (ref config) {
        config.port = 3000;
        config.host = "0.0.0.0";
        config.enableLogging = true;
        config.globalPrefix = "/api";
        config.enableCors = true;
    });
    
    app.listen();
}
```

### 7. Запуск

```bash
dub build
dub run
```

## 📁 Структура проекта

```
my-awesome-app/
├── dub.json
├── source/
│   ├── app.d
│   ├── app_module.d
│   └── user/
│       ├── user.controller.d
│       ├── user.service.d
│       └── user.mod.d
└── views/
    └── ...
```

## 🎨 Доступные API

### Декораторы:

- `@Controller(path)` - Контроллер
- `@Get(path)` / `@Post(path)` / `@Put(path)` / `@Delete(path)` / `@Patch(path)` - HTTP методы
- `@Injectable` - Провайдер для DI
- `@HttpCode(code)` - HTTP код ответа
- `@UseGuards(...)` / `@UseInterceptors(...)` / `@UsePipes(...)` / `@UseFilters(...)` - Middleware

### Классы:

- `NestModule` - Базовый класс модуля
- `DestApplication` - Приложение
- `DestFactory` - Фабрика приложений
- `DIContainer` - DI контейнер
- `ModuleManager` - Менеджер модулей

### Функции:

- `extractControllerMetadata!T()` - Извлечь метаданные контроллера
- `extractProviderMetadata!T()` - Извлечь метаданные провайдера
- `extractModuleMetadata!T()` - Извлечь метаданные модуля
- `printFrameworkInfo()` - Вывести информацию о фреймворке
- `getGlobalContainer()` - Получить глобальный DI контейнер

## 📖 Документация

- [Полное руководство](DESTD_FRAMEWORK.md)
- [Техническая документация](DESTD_IMPLEMENTATION.md)
- [Vibe.d Documentation](https://vibed.org/docs)

## 🎯 Примеры

Смотрите примеры в `source/examples/`:
- `examples/user_example.d` - Полный CRUD модуль
- `examples/app_module.d` - Корневой модуль
- `examples/main.d` - Точка входа

## 🚀 С CLI генератором

Используйте генератор для быстрого создания модулей:

```bash
# В вашем проекте
generator nestjs user
generator nestjs product
generator nestjs auth
```

---

**Happy coding with Dest.d! 🎯**

