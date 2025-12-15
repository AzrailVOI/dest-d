module generators.module_scanner;

import std.stdio;
import std.file : exists, dirEntries, SpanMode;
import std.path : buildPath, dirName, baseName;
import std.algorithm : endsWith;
import utils.string_utils;
import generators.directory_manager;

/// Структура для хранения информации о найденных модулях
struct ScannedModule
{
    string moduleName;
    string pascalName;
}

/// Сканирует директорию source и находит все модули (.mod.d файлы)
ScannedModule[] scanModules()
{
    ScannedModule[] modules;
    string sourceDir = getSourceDirectory();
    
    if (!exists(sourceDir))
    {
        writeln("Директория source не найдена");
        return modules;
    }
    
    foreach (entry; dirEntries(sourceDir, SpanMode.depth))
    {
        if (!entry.isDir && entry.name.endsWith(".mod.d"))
        {
            writeln("Обрабатываем файл: ", entry.name);
            enum suffix = ".mod.d";
            
            // Получаем имя родительской директории и имя файла
            string parentDir = baseName(dirName(entry.name));
            string fileName = baseName(entry.name);
            
            // Удаляем суффикс .mod.d, чтобы получить базовое имя модуля
            string moduleBaseName = fileName[0 .. fileName.length - suffix.length];
            
            writeln("  Родительская директория: '", parentDir, "', базовое имя модуля: '", moduleBaseName, "'");
            
            // Если имя родительской директории совпадает с базовым именем файла
            if (parentDir == moduleBaseName)
            {
                ScannedModule modInfo;
                modInfo.moduleName = moduleBaseName;
                modInfo.pascalName = toPascalCase(moduleBaseName);
                modules ~= modInfo;
                writeln("  Добавлен модуль: ", moduleBaseName);
            }
        }
    }
    
    return modules;
}

