# 🎯 Dest CLI - Quick Reference

## Команды

### Инициализация
```bash
dest init                              # Создать новый проект
```

### Генерация в Dest.d стиле
```bash
dest nestjs <name>                     # Модуль с декораторами и DI
```

### Генерация компонентов (NestJS CLI style)
```bash
dest generate <schematic> <name>       # Полная команда
dest g <schematic> <name>              # Короткая версия
```

## Schematics (Алиасы)

| Schematic | Alias | Описание |
|-----------|-------|----------|
| `resource` | `res` | Полный REST ресурс |
| `module` | `mo` | Модуль |
| `controller` | `co` | Контроллер |
| `service` | `s` | Сервис |
| `middleware` | `mi` | Middleware |
| `guard` | `gu` | Guard |
| `interceptor` | `in` | Interceptor |
| `filter` | `f` | Filter |
| `pipe` | `pi` | Pipe |
| `gateway` | `ga` | WebSocket Gateway |
| `resolver` | `r` | GraphQL Resolver |
| `provider` | `pr` | Provider |
| `class` | `cl` | Class |
| `interface` | `i` | Interface |
| `decorator` | `d` | Decorator |

## Примеры

### Быстрый старт
```bash
# 1. Создать проект
dest init

# 2. Создать REST API модули
dest nestjs user
dest nestjs product
dest nestjs order

# 3. Запустить
cd my-project
dub run
```

### Полное приложение
```bash
# Инициализация
dest init

# REST ресурсы
dest g res user
dest g res product
dest g res order

# Middleware стек
dest g mi logging
dest g mi cors
dest g mi compression

# Авторизация
dest g gu auth
dest g gu roles

# Валидация
dest g pi validation
dest g f http-exception

# WebSocket
dest g ga chat
dest g ga notifications

# Запуск
dub run
```

### Только компоненты
```bash
# Контроллеры
dest g co users
dest g co products

# Сервисы
dest g s email
dest g s payment
dest g s notification

# Классы
dest g cl user-dto
dest g cl product-entity
dest g i repository
```

## Опции

```bash
dest <name> crud                       # CRUD шаблон (по умолчанию)
dest <name> empty                      # Пустой шаблон

dest g <schematic> <name> --crud       # CRUD шаблон
dest g <schematic> <name> --empty      # Пустой шаблон
```

## Помощь

```bash
dest --help                            # Справка
dest -h                                # Краткая справка
dest help                              # Справка
```

## Структура проекта

```
my-project/
├── dub.json
├── source/
│   ├── app.d                          # Главное приложение
│   ├── user/                          # Модуль User
│   │   ├── user.controller.d
│   │   ├── user.service.d
│   │   └── user.mod.d
│   ├── product/                       # Модуль Product
│   │   ├── product.controller.d
│   │   ├── product.service.d
│   │   └── product.mod.d
│   └── ...
└── views/                             # Diet шаблоны
```

## Dest.d Framework

```bash
# Модуль с декораторами
dest nestjs auth
```

Создает:
- `auth.controller.d` - с `@Controller`, `@Get`, `@Post`
- `auth.service.d` - с `@Injectable`
- `auth.mod.d` - с DI контейнером

Использует:
- Декораторы (`@Controller`, `@Get`, `@Post`, `@Injectable`)
- Dependency Injection
- Автоматическая регистрация маршрутов
- Модульная система

## Ссылки

- [Полная документация](README.md)
- [Dest.d Framework](DESTD_FRAMEWORK.md)
- [NestJS CLI](NESTJS_CLI.md)
- [Vibe.d Docs](https://vibed.org/docs)

---

**Happy coding with Dest CLI! 🚀**

