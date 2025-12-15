# 🎯 Dest.d - Полная документация

## 🚀 Что такое Dest.d?

**Dest.d** - это современный асинхронный веб-фреймворк для D языка с декларативным синтаксисом, dependency injection и модульной архитектурой.

## ✨ Ключевые возможности

- 🎨 **Декларативный синтаксис** - Декораторы `@Controller`, `@Get`, `@Post`, `@Injectable`
- 💉 **Dependency Injection** - Автоматическое разрешение зависимостей
- 📦 **Модульная архитектура** - Организация кода в переиспользуемые модули
- 🔄 **Автомаршрутизация** - Маршруты извлекаются из метаданных
- 🛡️ **Guards & Interceptors** - Встроенная поддержка middleware
- 🌐 **CORS & Global Prefix** - Настройка из коробки
- ⚡ **Async/Non-blocking** - Полностью асинхронный
- 🔧 **Type-safe** - Статическая типизация D
- 📊 **Compile-time метаданные** - UDA извлекаются при компиляции

## 📦 Установка

### Как библиотека (dest-d)

Добавьте в `dub.json`:

```json
{
    "dependencies": {
        "dest-d": "~>1.0.0"
    }
}
```

Импортируйте:

```d
import dest;
```

### Как CLI генератор

```bash
git clone <repo-url>
cd dest-d
dub build
./dest --help
```

## 🎯 Быстрый старт

### Пример: REST API

```d
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
        res.writeBody(userService.findAll(), "application/json");
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
        data["id"] = 2;
        return data.toString();
    }
}

class UserModule : DestModule
{
    private UserService userService;
    private UserController userController;
    
    this()
    {
        super();
        
        container.register!UserService();
        userService = container.resolve!UserService();
        userController = new UserController(userService);
    }
    
    override void registerRoutes(URLRouter router)
    {
        auto meta = extractControllerMetadata!UserController();
        
        foreach (route; meta.routes)
        {
            string fullPath = meta.basePath ~ route.path;
            
            if (route.method == "GET" && route.handler == "findAll")
                router.get(fullPath, &userController.findAll);
            else if (route.method == "POST" && route.handler == "create")
                router.post(fullPath, &userController.create);
        }
    }
}

class AppModule : DestModule
{
    private UserModule userModule;
    
    this()
    {
        super();
        userModule = new UserModule();
        userModule.registerModule();
    }
    
    override void registerRoutes(URLRouter router)
    {
        userModule.registerRoutes(router);
        
        router.get("/", (req, res) {
            res.writeBody(`{"message": "Welcome to Dest.d!"}`, "application/json");
        });
    }
}

void main()
{
    printFrameworkInfo();
    
    auto app = DestFactory.create(new AppModule(), (ref config) {
        config.port = 3000;
        config.globalPrefix = "/api";
        config.enableCors = true;
    });
    
    app.listen();
}
```

## 🎨 CLI Генератор

### Команды

```bash
dest init                    # Новый проект
dest module user             # Модуль с декораторами
dest g res product           # REST ресурс
dest g co orders             # Контроллер
dest g s email               # Сервис
dest g mi logging            # Middleware
dest g gu auth               # Guard
dest g in timing             # Interceptor
dest g f exception           # Filter
dest g pi validation         # Pipe
dest g ga chat               # WebSocket Gateway
dest g r user                # GraphQL Resolver
dest g cl dto                # Class
dest g i repository          # Interface
dest g d custom              # Decorator
```

## 🎯 Dest.d Framework

### Декораторы

#### Классы
- `@Controller(path)` - HTTP контроллер
- `@Injectable` - Провайдер для DI

#### HTTP методы
- `@Get(path)` - GET запрос
- `@Post(path)` - POST запрос
- `@Put(path)` - PUT запрос
- `@Delete(path)` - DELETE запрос
- `@Patch(path)` - PATCH запрос

#### Параметры
- `@Body()` - Тело запроса
- `@Param(name)` - Параметр из URL
- `@Query(name)` - Query параметр
- `@Header(name)` - HTTP заголовок
- `@Req()` / `@Res()` - Объекты запроса/ответа

#### Middleware
- `@UseGuards(...)` - Применить guards
- `@UseInterceptors(...)` - Применить interceptors
- `@UsePipes(...)` - Применить pipes
- `@UseFilters(...)` - Применить filters

#### Другие
- `@HttpCode(code)` - HTTP код ответа
- `@WebSocketGateway` - WebSocket gateway

### DI Контейнер

```d
// Регистрация
container.register!MyService();

// Получение инстанса
auto service = container.resolve!MyService();

// Создание с параметрами
auto instance = container.create!MyClass(param1, param2);
```

### Система модулей

```d
class MyModule : DestModule
{
    this()
    {
        super();
        
        // Регистрация провайдеров
        container.register!MyService();
        
        // Создание инстансов
        myService = container.resolve!MyService();
        
        // Метаданные
        metadata.moduleName = "MyModule";
        metadata.providers = ["MyService"];
    }
    
    override void registerRoutes(URLRouter router)
    {
        // Регистрация маршрутов
    }
}
```

### Приложение

```d
void main()
{
    auto app = DestFactory.create(new AppModule(), (ref config) {
        config.port = 3000;
        config.host = "0.0.0.0";
        config.enableLogging = true;
        config.globalPrefix = "/api";
        config.enableCors = true;
    });
    
    app.listen();
}
```

## 📁 Структура проекта

```
my-app/
├── dub.json
├── source/
│   ├── app.d                    # Точка входа
│   ├── app_module.d             # Корневой модуль
│   ├── user/                    # Модуль User
│   │   ├── user.controller.d
│   │   ├── user.service.d
│   │   └── user.mod.d
│   ├── product/                 # Модуль Product
│   │   ├── product.controller.d
│   │   ├── product.service.d
│   │   └── product.mod.d
│   └── ...
└── views/                       # Diet шаблоны
```

## 📚 Документация

- **[DESTD_FRAMEWORK.md](DESTD_FRAMEWORK.md)** - Полное руководство по фреймворку
- **[DESTD_USAGE.md](DESTD_USAGE.md)** - Примеры использования библиотеки
- **[DESTD_PACKAGE.md](DESTD_PACKAGE.md)** - Информация о пакете
- **[CLI_REFERENCE.md](CLI_REFERENCE.md)** - Справка по CLI командам

## 🎉 Примеры

Смотрите `source/examples/`:
- `examples/user_example.d` - Полный CRUD модуль
- `examples/app_module.d` - Корневой модуль
- `examples/main.d` - Запуск приложения

## 🤝 Вклад

Приветствуются pull requests! Для серьезных изменений сначала откройте issue.

## 📄 Лицензия

MIT

---

**Создавайте масштабируемые приложения с Dest.d! 🎯**
