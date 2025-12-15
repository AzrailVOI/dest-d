module generators.advanced.websocket_gen;

import std.stdio;
import std.file : write;
import std.format : format;
import std.path : buildPath;
import utils.string_utils;
import generators.directory_manager;
import templates.websocket;

/// Генерирует Gateway
void generateGateway(string name, string targetDir = null)
{
    string moduleName = name;
    string ModuleName = toPascalCase(name);
    string dirPath = targetDir is null ? buildPath(getSourceDirectory(), moduleName) : targetDir;
    
    ensureDirectoryExists(dirPath);
    
    string filePath = buildPath(dirPath, moduleName ~ ".gateway.d");
    string content = format(GATEWAY_TEMPLATE,
        moduleName, moduleName, ModuleName, ModuleName);
    
    write(filePath, content);
    writeln("✓ Gateway создан: ", filePath);
}

/// Генерирует Resolver
void generateResolver(string name, string targetDir = null)
{
    string moduleName = name;
    string ModuleName = toPascalCase(name);
    string dirPath = targetDir is null ? buildPath(getSourceDirectory(), moduleName) : targetDir;
    
    ensureDirectoryExists(dirPath);
    
    string filePath = buildPath(dirPath, moduleName ~ ".resolver.d");
    string content = format(RESOLVER_TEMPLATE,
        moduleName, moduleName, ModuleName, ModuleName);
    
    write(filePath, content);
    writeln("✓ Resolver создан: ", filePath);
}


