module cli.usage;

import std.stdio;

/// Выводит справку по использованию программы
void printUsage()
{
    writeln("Dest.d CLI Generator - генератор модулей для D проектов");
    writeln("Powered by Dest.d Framework");
    writeln();
    writeln("Использование:");
    writeln("  dest init                                    - Инициализировать новый проект");
    writeln("  dest generate <schematic> <name> [options]   - Генерировать компонент");
    writeln("  dest g <schematic> <name> [options]          - Короткая версия generate");
    writeln("  dest module <module_name>                    - Создать модуль в Dest.d стиле");
    writeln();
    writeln("Команды:");
    writeln("  init                  Создать новый проект с интерактивной настройкой");
    writeln("  generate, g           Генерировать различные компоненты");
    writeln("  module                Генерировать модуль в Dest.d стиле с декораторами");
    writeln();
    writeln("Schematics (типы компонентов):");
    writeln("  module (mo)           Модуль с контроллером и сервисом");
    writeln("  controller (co)       Контроллер для HTTP запросов");
    writeln("  service (s)           Сервис с бизнес-логикой");
    writeln("  resource (res)        Полный REST ресурс (module + controller + service)");
    writeln("  middleware (mi)       Middleware для обработки запросов");
    writeln("  guard (gu)            Guard для авторизации");
    writeln("  interceptor (in)      Interceptor для модификации запросов/ответов");
    writeln("  filter (f)            Filter для обработки исключений");
    writeln("  pipe (pi)             Pipe для валидации данных");
    writeln("  gateway (ga)          WebSocket Gateway");
    writeln("  class (cl)            Обычный D класс");
    writeln("  interface (i)         D интерфейс");
    writeln();
    writeln("Options:");
    writeln("  --crud                Создать с CRUD методами (по умолчанию)");
    writeln("  --empty               Создать пустой шаблон");
    writeln();
    writeln("Примеры:");
    writeln("  dest init                                # Создать новый проект");
    writeln("  dest generate resource user              # REST ресурс user");
    writeln("  dest g module auth                       # Модуль auth");
    writeln("  dest g controller products --crud        # CRUD контроллер products");
    writeln("  dest g service payment --empty           # Пустой сервис payment");
    writeln("  dest g middleware logging                # Middleware logging");
    writeln("  dest g class dto/user                    # Класс UserDTO");
    writeln();
}


