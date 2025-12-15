# 📦 Dest.d Library Package

## Структура репозитория

```
dest-d/
├── dub.json                  # Конфигурация CLI генератора
├── dest-d.json              # Конфигурация библиотеки Dest.d
├── source/
│   ├── dest/                # 🎯 Библиотека Dest.d Framework
│   │   ├── package.d        # import dest;
│   │   ├── decorators.d     # dest.decorators
│   │   ├── metadata.d       # dest.metadata
│   │   ├── di_container.d   # dest.di_container
│   │   ├── module_system.d  # dest.module_system
│   │   └── application.d    # dest.application
│   ├── examples/            # Примеры использования
│   ├── generators/          # Генераторы кода
│   ├── templates/           # Шаблоны генератора
│   ├── utils/               # Утилиты генератора
│   └── app.d                # CLI генератор
└── README.md

```

## 🚀 Два способа использования

### 1. Как библиотека в вашем проекте

**Добавьте зависимость в ваш проект:**

```json
{
    "name": "my-app",
    "dependencies": {
        "dest-d": "~>1.0.0"
    }
}
```

**Используйте в коде:**

```d
import dest;  // Импортирует весь фреймворк

void main()
{
    auto app = DestFactory.create(new AppModule());
    app.listen();
}
```

### 2. Как CLI генератор

**Клонируйте репозиторий:**

```bash
git clone https://github.com/yourusername/dest-d.git
cd dest-d
dub build
```

**Используйте генератор:**

```bash
# Инициализация проекта
./generator init

# Генерация модулей в Dest.d стиле
./generator nestjs user
./generator nestjs product

# Генерация компонентов
./generator g controller items
./generator g service email
./generator g middleware logging
```

## 📦 Сборка библиотеки

### Сборка с использованием dest-d.json

```bash
# Собрать библиотеку
dub build --config=library --root=. --recipe=dest-d.json

# Запустить примеры
dub run dest-d:examples --recipe=dest-d.json
```

### Сборка генератора

```bash
# Используется dub.json (по умолчанию)
dub build
dub run
```

## 🎯 Импорты в вашем проекте

После добавления зависимости `dest-d`:

```d
// Импорт всего фреймворка
import dest;

// Или выборочно
import dest.decorators;
import dest.di_container;
import dest.module_system;
import dest.application;
```

## 📁 Что входит в библиотеку

### dest/package.d
Публичный API - экспортирует все модули

### dest/decorators.d
- `@Controller(path)`
- `@Get(path)`, `@Post(path)`, `@Put(path)`, `@Delete(path)`, `@Patch(path)`
- `@Injectable`
- `@HttpCode(code)`
- `@Body()`, `@Param(name)`, `@Query(name)`, `@Header(name)`
- `@UseGuards(...)`, `@UseInterceptors(...)`, `@UsePipes(...)`, `@UseFilters(...)`

### dest/metadata.d
- `extractControllerMetadata!T()`
- `extractProviderMetadata!T()`
- `extractModuleMetadata!T()`

### dest/di_container.d
- `DIContainer` класс
- `getGlobalContainer()`

### dest/module_system.d
- `NestModule` базовый класс
- `ModuleManager`

### dest/application.d
- `DestApplication`
- `DestFactory`
- `ApplicationConfig`

## 📖 Документация

- **[DESTD_FRAMEWORK.md](DESTD_FRAMEWORK.md)** - Полное руководство
- **[DESTD_USAGE.md](DESTD_USAGE.md)** - Примеры использования
- **[DESTD_IMPLEMENTATION.md](DESTD_IMPLEMENTATION.md)** - Техническая документация

## 🎨 Пример: Использование как библиотеки

**my-app/dub.json:**
```json
{
    "name": "my-app",
    "dependencies": {
        "dest-d": "~>1.0.0"
    }
}
```

**my-app/source/app.d:**
```d
import dest;

@Controller("/api/users")
class UserController
{
    @Get("")
    void findAll(HTTPServerRequest req, HTTPServerResponse res)
    {
        res.writeBody(`{"users": []}`, "application/json");
    }
}

class UserModule : NestModule
{
    // ... регистрация маршрутов
}

class AppModule : NestModule
{
    // ... импорт модулей
}

void main()
{
    auto app = DestFactory.create(new AppModule(), (ref config) {
        config.port = 3000;
        config.globalPrefix = "/api";
    });
    
    app.listen();
}
```

## 🔧 Разработка

### Структура для разработчиков библиотеки

```bash
# Редактировать исходники библиотеки
source/dest/*.d

# Тестировать изменения
dub build --recipe=dest-d.json
dub run dest-d:examples --recipe=dest-d.json

# Обновить генератор
dub build  # использует dub.json
```

## 📦 Публикация на DUB registry

1. Убедитесь, что `dest-d.json` корректен
2. Создайте git tag: `git tag v1.0.0`
3. Отправьте на GitHub: `git push origin v1.0.0`
4. Зарегистрируйте на https://code.dlang.org/

---

**Dest.d = Библиотека + Генератор в одном репозитории! 🎯**


