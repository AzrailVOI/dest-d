module generators.config_reader;

import std.stdio;
import std.string : strip, toLower;
import std.conv : to;

/// Структура конфигурации проекта
struct ProjectConfig
{
    string projectName;
    string projectDescription;
    string author;
    ushort serverPort;
    string serverHost;
    bool enableLogging;
    string license;
}

/// Читает строку от пользователя с значением по умолчанию
string readLineWithDefault(string defaultValue)
{
    string input = readln().strip();
    return input.length > 0 ? input : defaultValue;
}

/// Читает число от пользователя с значением по умолчанию
ushort readPortWithDefault(ushort defaultValue)
{
    string input = readln().strip();
    if (input.length == 0)
        return defaultValue;
    
    try
    {
        ushort port = to!ushort(input);
        if (port < 1024 || port > 65535)
        {
            writeln("Предупреждение: порт должен быть между 1024 и 65535, использую значение по умолчанию.");
            return defaultValue;
        }
        return port;
    }
    catch (Exception e)
    {
        writeln("Неверное значение, использую значение по умолчанию.");
        return defaultValue;
    }
}

/// Читает Yes/No от пользователя
bool readYesNo(bool defaultValue)
{
    string input = readln().strip().toLower();
    if (input.length == 0)
        return defaultValue;
    
    return input == "y" || input == "yes" || input == "да";
}

/// Интерактивное меню настроек проекта
ProjectConfig interactiveSetup()
{
    ProjectConfig config;
    
    writeln();
    writeln("╔═══════════════════════════════════════════════════════════════╗");
    writeln("║         Инициализация нового Dest.d проекта                  ║");
    writeln("╚═══════════════════════════════════════════════════════════════╝");
    writeln();
    
    // Имя проекта
    write("Имя проекта [my-dest-app]: ");
    config.projectName = readLineWithDefault("my-dest-app");
    
    // Описание
    write("Описание проекта [A web application built with Dest.d]: ");
    config.projectDescription = readLineWithDefault("A web application built with Dest.d");
    
    // Автор
    write("Автор [Unknown]: ");
    config.author = readLineWithDefault("Unknown");
    
    // Лицензия
    write("Лицензия [MIT]: ");
    config.license = readLineWithDefault("MIT");
    
    writeln();
    writeln("--- Настройки сервера ---");
    
    // Порт сервера
    write("Порт сервера [8080]: ");
    config.serverPort = readPortWithDefault(8080);
    
    // Хост сервера
    write("Хост сервера [0.0.0.0]: ");
    config.serverHost = readLineWithDefault("0.0.0.0");
    
    // Логирование
    write("Включить логирование? [Y/n]: ");
    config.enableLogging = readYesNo(true);
    
    writeln();
    writeln("--- Сводка конфигурации ---");
    writeln("Проект:      ", config.projectName);
    writeln("Описание:    ", config.projectDescription);
    writeln("Автор:       ", config.author);
    writeln("Лицензия:    ", config.license);
    writeln("Сервер:      ", config.serverHost, ":", config.serverPort);
    writeln("Логирование: ", config.enableLogging ? "Да" : "Нет");
    writeln();
    
    write("Создать проект с этими настройками? [Y/n]: ");
    if (!readYesNo(true))
    {
        throw new Exception("Инициализация отменена пользователем");
    }
    
    return config;
}

