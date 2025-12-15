module generators.advanced.middleware_gen;

import std.stdio;
import std.file : write;
import std.format : format;
import std.path : buildPath;
import utils.string_utils;
import generators.directory_manager;
import templates.advanced;

/// Генерирует Middleware
void generateMiddleware(string name, string targetDir = null)
{
    string moduleName = name;
    string ModuleName = toPascalCase(name);
    string dirPath = targetDir is null ? buildPath(getSourceDirectory(), moduleName) : targetDir;
    
    ensureDirectoryExists(dirPath);
    
    string filePath = buildPath(dirPath, moduleName ~ ".middleware.d");
    string content = format(MIDDLEWARE_TEMPLATE,
        moduleName, moduleName, ModuleName, moduleName);
    
    write(filePath, content);
    writeln("✓ Middleware создан: ", filePath);
}

/// Генерирует Guard
void generateGuard(string name, string targetDir = null)
{
    string moduleName = name;
    string ModuleName = toPascalCase(name);
    string dirPath = targetDir is null ? buildPath(getSourceDirectory(), moduleName) : targetDir;
    
    ensureDirectoryExists(dirPath);
    
    string filePath = buildPath(dirPath, moduleName ~ ".guard.d");
    string content = format(GUARD_TEMPLATE,
        moduleName, moduleName, ModuleName);
    
    write(filePath, content);
    writeln("✓ Guard создан: ", filePath);
}

/// Генерирует Interceptor
void generateInterceptor(string name, string targetDir = null)
{
    string moduleName = name;
    string ModuleName = toPascalCase(name);
    string dirPath = targetDir is null ? buildPath(getSourceDirectory(), moduleName) : targetDir;
    
    ensureDirectoryExists(dirPath);
    
    string filePath = buildPath(dirPath, moduleName ~ ".interceptor.d");
    string content = format(INTERCEPTOR_TEMPLATE,
        moduleName, moduleName, ModuleName);
    
    write(filePath, content);
    writeln("✓ Interceptor создан: ", filePath);
}

/// Генерирует Filter
void generateFilter(string name, string targetDir = null)
{
    string moduleName = name;
    string ModuleName = toPascalCase(name);
    string dirPath = targetDir is null ? buildPath(getSourceDirectory(), moduleName) : targetDir;
    
    ensureDirectoryExists(dirPath);
    
    string filePath = buildPath(dirPath, moduleName ~ ".filter.d");
    string content = format(FILTER_TEMPLATE,
        moduleName, moduleName, ModuleName);
    
    write(filePath, content);
    writeln("✓ Filter создан: ", filePath);
}

/// Генерирует Pipe
void generatePipe(string name, string targetDir = null)
{
    string moduleName = name;
    string ModuleName = toPascalCase(name);
    string dirPath = targetDir is null ? buildPath(getSourceDirectory(), moduleName) : targetDir;
    
    ensureDirectoryExists(dirPath);
    
    string filePath = buildPath(dirPath, moduleName ~ ".pipe.d");
    string content = format(PIPE_TEMPLATE,
        moduleName, moduleName, ModuleName);
    
    write(filePath, content);
    writeln("✓ Pipe создан: ", filePath);
}


