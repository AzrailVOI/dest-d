module generators.destd.app_gen;

import std.stdio;
import std.file : write;
import std.format : format;
import std.path : buildPath;
import utils.string_utils;
import generators.directory_manager;
import templates.app;

/// Генерирует AppModule с импортами
void generateAppModule(string[] modules = [])
{
    string sourceDir = getSourceDirectory();
    string appModulePath = buildPath(sourceDir, "app_module.d");
    
    string imports = generateImports(modules);
    string fields = generateFields(modules);
    string initialization = generateInitialization(modules);
    string metadataImports = generateMetadataImports(modules);
    string routeRegistration = generateRouteRegistration(modules);
    string endpoints = generateEndpoints(modules);
    
    string content = format(DESTD_APP_MODULE_TEMPLATE,
        imports, fields, initialization, metadataImports, routeRegistration, endpoints);
    
    write(appModulePath, content);
    writeln("✓ AppModule обновлен: ", appModulePath);
}

private string generateImports(string[] modules)
{
    string imports = "";
    foreach (mod; modules)
    {
        imports ~= format("import %s.%s.mod;\n", mod, mod);
    }
    return imports;
}

private string generateFields(string[] modules)
{
    string fields = "";
    foreach (mod; modules)
    {
        string ModuleName = toPascalCase(mod);
        fields ~= format("    private %sModule %sModule;\n", ModuleName, mod);
    }
    return fields;
}

private string generateInitialization(string[] modules)
{
    string initialization = "";
    foreach (mod; modules)
    {
        string ModuleName = toPascalCase(mod);
        initialization ~= format("        %sModule = new %sModule();\n", mod, ModuleName);
        initialization ~= format("        %sModule.registerModule();\n", mod);
    }
    return initialization;
}

private string generateMetadataImports(string[] modules)
{
    string metadataImports = "";
    foreach (i, mod; modules)
    {
        string ModuleName = toPascalCase(mod);
        metadataImports ~= format("\"%sModule\"", ModuleName);
        if (i < modules.length - 1) metadataImports ~= ", ";
    }
    return metadataImports;
}

private string generateRouteRegistration(string[] modules)
{
    string routeRegistration = "";
    foreach (mod; modules)
    {
        routeRegistration ~= format("        %sModule.registerRoutes(router);\n", mod);
    }
    return routeRegistration;
}

private string generateEndpoints(string[] modules)
{
    string endpoints = "";
    foreach (mod; modules)
    {
        endpoints ~= format("            response[\"endpoints\"] ~= \"/%s\";\n", mod);
    }
    return endpoints;
}

/// Генерирует main.d
void generateMain(ushort port = 3000, string host = "0.0.0.0", 
                  bool enableLogging = true, string globalPrefix = "/api", bool enableCors = true)
{
    string sourceDir = getSourceDirectory();
    string mainPath = buildPath(sourceDir, "app.d");
    
    string content = format(DESTD_MAIN_TEMPLATE,
        port, host, enableLogging, globalPrefix, enableCors);
    
    write(mainPath, content);
    writeln("✓ Main файл создан: ", mainPath);
}


