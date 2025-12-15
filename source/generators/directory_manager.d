module generators.directory_manager;

import std.stdio;
import std.file : getcwd, exists, isDir, mkdirRecurse;
import std.path : buildPath;

/// Создает директорию, если она не существует
void ensureDirectoryExists(string dirPath)
{
    if (!(exists(dirPath) && isDir(dirPath)))
    {
        mkdirRecurse(dirPath);
        writeln("Создан каталог: ", dirPath);
    }
    else
    {
        writeln("Каталог уже существует: ", dirPath);
    }
}

/// Получает путь к директории source проекта пользователя
/// ВАЖНО: создает в текущей директории, а не в директории генератора!
string getSourceDirectory()
{
    string currentDir = getcwd();
    writeln("Текущая директория: ", currentDir);
    
    // Проверяем, не находимся ли мы в директории самого генератора
    string thisSourceDir = buildPath(currentDir, "source");
    
    // Если в текущей директории уже есть source с модулями генератора,
    // НЕ используем её для генерации проектов!
    // В этом случае генерируем в ./generated/source
    if (exists(buildPath(thisSourceDir, "generators")) || 
        exists(buildPath(thisSourceDir, "templates")) ||
        exists(buildPath(thisSourceDir, "utils")))
    {
        writeln("ВНИМАНИЕ: Обнаружена директория генератора!");
        writeln("Генерация будет выполнена в: ./generated/source");
        string generatedDir = buildPath(currentDir, "generated", "source");
        return generatedDir;
    }
    
    return thisSourceDir;
}

/// Создает структуру директорий для модуля
string createModuleStructure(string moduleName)
{
    string sourceDir = getSourceDirectory();
    ensureDirectoryExists(sourceDir);
    
    string moduleDir = buildPath(sourceDir, moduleName);
    ensureDirectoryExists(moduleDir);
    writeln("Каталог для модуля готов: ", moduleDir);
    
    return moduleDir;
}

/// Получает путь к файлу контроллера
string getControllerFilePath(string moduleDir, string moduleName)
{
    return buildPath(moduleDir, moduleName ~ ".controller.d");
}

/// Получает путь к файлу сервиса
string getServiceFilePath(string moduleDir, string moduleName)
{
    return buildPath(moduleDir, moduleName ~ ".service.d");
}

/// Получает путь к файлу модуля
string getModuleFilePath(string moduleDir, string moduleName)
{
    return buildPath(moduleDir, moduleName ~ ".mod.d");
}

/// Получает путь к файлу app.d ПРОЕКТА (не генератора!)
string getAppFilePath()
{
    string sourceDir = getSourceDirectory();
    
    // Если генерируем в generated/, то создаем app.d там
    // Если в обычной директории пользователя - создаем в source/
    return buildPath(sourceDir, "app.d");
}


