# 🎯 Dest.d Framework

**NestJS-inspired метафреймворк для vibe.d**

## 🚀 Что такое Dest.d?

**Dest.d** - это современный, декларативный метафреймворк для создания масштабируемых серверных приложений на D, вдохновленный архитектурой [NestJS](https://docs.nestjs.com). Он построен поверх [vibe.d](https://vibed.org) и предоставляет мощную систему модулей, dependency injection и декораторов.

### ✨ Ключевые возможности

- 🎨 **Декларативный синтаксис** - Используйте декораторы `@Controller`, `@Get`, `@Post`, `@Injectable`
- 💉 **Dependency Injection** - Мощная DI система с автоматическим разрешением зависимостей
- 📦 **Модульная архитектура** - Организуйте код в переиспользуемые модули
- 🔄 **Автоматическая маршрутизация** - Маршруты извлекаются из метаданных декораторов
- 🛡️ **Guards & Interceptors** - Встроенная поддержка middleware, guards, interceptors, pipes
- 🌐 **CORS & Global Prefix** - Настройка глобальных префиксов и CORS из коробки
- ⚡ **Async/Non-blocking** - Полностью асинхронный, основан на vibe.d

## 📦 Установка

```bash
# Клонируйте генератор
git clone <repo-url>
cd vibed-nest-generator

# Соберите генератор
dub build

# Используйте генератор
./generator nestjs myapp
```

## 🎯 Быстрый старт

### 1. Создайте контроллер

```d
import core;

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
    
    @Get("/:id")
    void findOne(HTTPServerRequest req, HTTPServerResponse res)
    {
        auto id = req.params["id"];
        auto user = userService.findOne(id);
        res.writeBody(user, "application/json");
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

### 2. Создайте сервис

```d
import core;

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
        Json user = Json(["id": id, "name": "User " ~ id]);
        return user.toString();
    }
    
    string create(Json data)
    {
        // Логика создания
        return data.toString();
    }
}
```

### 3. Создайте модуль

```d
import core;

class UserModule : NestModule
{
    private UserService userService;
    private UserController userController;
    
    this()
    {
        super();
        
        // Регистрируем сервис в DI контейнере
        container.register!UserService();
        
        // Создаем инстансы с автоматическим DI
        userService = container.resolve!UserService();
        userController = new UserController(userService);
        
        // Метаданные модуля
        metadata.moduleName = "UserModule";
        metadata.providers = ["UserService"];
        metadata.controllers = ["UserController"];
    }
    
    override void registerRoutes(URLRouter router)
    {
        auto meta = extractControllerMetadata!UserController();
        
        // Автоматическая регистрация маршрутов из декораторов
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

### 4. Создайте корневой модуль

```d
import core;

class AppModule : NestModule
{
    private UserModule userModule;
    
    this()
    {
        super();
        
        // Импортируем другие модули
        userModule = new UserModule();
        userModule.registerModule();
        
        metadata.moduleName = "AppModule";
        metadata.imports = ["UserModule"];
    }
    
    override void registerRoutes(URLRouter router)
    {
        userModule.registerRoutes(router);
        
        // Корневой маршрут
        router.get("/", (req, res) {
            res.writeBody(`{"message": "Welcome to Dest.d API"}`, "application/json");
        });
    }
}
```

### 5. Запустите приложение

```d
import core;

void main()
{
    // Печатаем информацию о фреймворке
    printFrameworkInfo();
    
    // Создаем корневой модуль
    auto appModule = new AppModule();
    
    // Создаем приложение через фабрику
    auto app = DestFactory.create(appModule, (ref config) {
        config.port = 3000;
        config.host = "0.0.0.0";
        config.enableLogging = true;
        config.globalPrefix = "/api";
        config.enableCors = true;
    });
    
    // Запускаем приложение
    app.listen();
}
```

## 🎨 Декораторы

### Декораторы классов

- `@Controller(path)` - Объявляет класс как контроллер
- `@Injectable` - Объявляет класс как провайдер для DI
- `@WebSocketGateway` - WebSocket gateway

### HTTP декораторы методов

- `@Get(path)` - GET запрос
- `@Post(path)` - POST запрос
- `@Put(path)` - PUT запрос
- `@Delete(path)` - DELETE запрос
- `@Patch(path)` - PATCH запрос
- `@HttpCode(code)` - Устанавливает HTTP код ответа

### Декораторы параметров

- `@Body()` - Извлекает тело запроса
- `@Param(name)` - Извлекает параметр из пути
- `@Query(name)` - Извлекает параметр из query string
- `@Header(name)` - Извлекает заголовок
- `@Req()` - Весь объект запроса
- `@Res()` - Весь объект ответа

### Middleware декораторы

- `@UseGuards(...)` - Применяет guards
- `@UseInterceptors(...)` - Применяет interceptors
- `@UsePipes(...)` - Применяет pipes для валидации
- `@UseFilters(...)` - Применяет exception filters

## 🏗️ Архитектура

```
Dest.d Architecture
│
├── core/
│   ├── decorators.d         # Система декораторов
│   ├── metadata.d           # Извлечение метаданных
│   ├── di_container.d       # DI контейнер
│   ├── module_system.d      # Система модулей
│   ├── application.d        # Главное приложение
│   └── package.d            # Публичный API
│
├── Module System
│   ├── NestModule           # Базовый класс модуля
│   ├── ModuleManager        # Менеджер модулей
│   └── Auto-registration    # Автоматическая регистрация
│
├── DI Container
│   ├── Singleton scope      # Одиночки
│   ├── Request scope        # На запрос
│   ├── Transient scope      # Каждый раз новый
│   └── Auto-resolution      # Автоматическое разрешение
│
└── Application
    ├── DestFactory          # Фабрика приложений
    ├── DestApplication      # Главное приложение
    ├── Configuration        # Конфигурация
    └── Router               # URLRouter из vibe.d
```

## 📚 Примеры использования

### REST API

```bash
# Генерируем модуль User с помощью CLI
generator nestjs user

# Генерируем модуль Product
generator nestjs product

# Запускаем приложение
dub run
```

### WebSocket Gateway

```d
@WebSocketGateway
class ChatGateway
{
    @SubscribeMessage("message")
    void handleMessage(string message)
    {
        // Обработка WebSocket сообщений
    }
}
```

### Guards (авторизация)

```d
class AuthGuard
{
    bool canActivate(HTTPServerRequest req, HTTPServerResponse res)
    {
        auto token = req.headers.get("Authorization", "");
        if (!validateToken(token))
        {
            res.statusCode = 401;
            res.writeBody(`{"error": "Unauthorized"}`, "application/json");
            return false;
        }
        return true;
    }
}

// Использование
@Controller("/admin")
@UseGuards(["AuthGuard"])
class AdminController { ... }
```

## 🛠️ Конфигурация

```d
auto app = DestFactory.create(appModule, (ref config) {
    config.port = 3000;                  // Порт сервера
    config.host = "0.0.0.0";            // Хост
    config.enableLogging = true;         // Логирование
    config.globalPrefix = "/api";        // Глобальный префикс
    config.enableCors = true;            // CORS
});
```

## 🎯 CLI Генератор

```bash
# Генерация модуля в Dest.d стиле
generator nestjs <module_name>

# Примеры
dest module user      # Создает user.controller.d, user.service.d, user.mod.d
dest module product   # Создает product модуль
generator nestjs auth      # Создает auth модуль
```

## 🆚 Сравнение с другими фреймворками

| Функция | Dest.d | vibe.d | NestJS (TypeScript) |
|---------|--------|--------|---------------------|
| Декораторы | ✅ | ❌ | ✅ |
| DI контейнер | ✅ | ❌ | ✅ |
| Модули | ✅ | ❌ | ✅ |
| Автомаршрутизация | ✅ | ❌ | ✅ |
| Метаданные | ✅ | ❌ | ✅ |
| Производительность | ⚡⚡⚡ | ⚡⚡⚡ | ⚡⚡ |
| Type Safety | ✅ (D) | ✅ (D) | ✅ (TS) |

## 🌟 Преимущества Dest.d

1. **🚀 Производительность D + vibe.d** - Нативная скорость компиляции и выполнения
2. **🎨 Элегантный синтаксис** - Чистый, читаемый код как в NestJS
3. **💉 Мощный DI** - Автоматическое разрешение зависимостей
4. **📦 Модульность** - Легко масштабируемая архитектура
5. **🔧 Типобезопасность** - Статическая типизация D
6. **⚡ Async из коробки** - Полностью асинхронный на базе vibe.d

## 📖 Документация

- [Vibe.d Documentation](https://vibed.org/docs)
- [NestJS Documentation](https://docs.nestjs.com) (для концепций)
- [D Language Documentation](https://dlang.org/spec/spec.html)

## 🤝 Вклад в проект

Приветствуются pull requests! Для серьезных изменений сначала откройте issue.

## 📄 Лицензия

MIT

## 🎉 Заключение

**Dest.d** объединяет лучшее из двух миров:
- Производительность и типобезопасность **D**
- Архитектуру и паттерны **NestJS**
- Асинхронность и экосистему **vibe.d**

**Создавайте масштабируемые, производительные серверные приложения с удовольствием! 🚀**

---

Made with ❤️ for the D community

