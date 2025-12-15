module generators.advanced.types_gen;

import std.stdio;
import std.file : write;
import std.format : format;
import std.path : buildPath;
import utils.string_utils;
import generators.directory_manager;
import templates.types;

/// Генерирует Class
void generateClass(string name, string targetDir = null)
{
    string moduleName = name;
    string ModuleName = toPascalCase(name);
    string dirPath = targetDir is null ? buildPath(getSourceDirectory(), "classes") : targetDir;
    
    ensureDirectoryExists(dirPath);
    
    string filePath = buildPath(dirPath, moduleName ~ ".d");
    string content = format(CLASS_TEMPLATE,
        "classes", moduleName, ModuleName, ModuleName);
    
    write(filePath, content);
    writeln("✓ Class создан: ", filePath);
}

/// Генерирует Interface
void generateInterface(string name, string targetDir = null)
{
    string moduleName = name;
    string ModuleName = toPascalCase(name);
    string dirPath = targetDir is null ? buildPath(getSourceDirectory(), "interfaces") : targetDir;
    
    ensureDirectoryExists(dirPath);
    
    string filePath = buildPath(dirPath, moduleName ~ ".d");
    string content = format(INTERFACE_TEMPLATE,
        "interfaces", moduleName, ModuleName, ModuleName);
    
    write(filePath, content);
    writeln("✓ Interface создан: ", filePath);
}

/// Генерирует Provider
void generateProvider(string name, string targetDir = null)
{
    string moduleName = name;
    string ModuleName = toPascalCase(name);
    string dirPath = targetDir is null ? buildPath(getSourceDirectory(), moduleName) : targetDir;
    
    ensureDirectoryExists(dirPath);
    
    string filePath = buildPath(dirPath, moduleName ~ ".provider.d");
    string content = format(PROVIDER_TEMPLATE,
        moduleName, moduleName, ModuleName, ModuleName);
    
    write(filePath, content);
    writeln("✓ Provider создан: ", filePath);
}

/// Генерирует Decorator
void generateDecorator(string name, string targetDir = null)
{
    string moduleName = name;
    string ModuleName = toPascalCase(name);
    string dirPath = targetDir is null ? buildPath(getSourceDirectory(), "decorators") : targetDir;
    
    ensureDirectoryExists(dirPath);
    
    string filePath = buildPath(dirPath, moduleName ~ ".d");
    string content = format(DECORATOR_TEMPLATE,
        "decorators", moduleName, ModuleName, ModuleName, ModuleName, ModuleName);
    
    write(filePath, content);
    writeln("✓ Decorator создан: ", filePath);
}


