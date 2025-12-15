module generators.destd.module_gen;

import std.stdio;
import std.file : write;
import std.format : format;
import std.path : buildPath;
import utils.string_utils;
import generators.directory_manager;
import templates.base;

/// Генерирует модуль в destd стиле
void generateDestdModule(string moduleName, string targetDir = null)
{
    string ModuleName = toPascalCase(moduleName);
    string dirPath = targetDir is null ? buildPath(getSourceDirectory(), moduleName) : targetDir;
    
    ensureDirectoryExists(dirPath);
    
    generateController(dirPath, moduleName, ModuleName);
    generateService(dirPath, moduleName, ModuleName);
    generateModule(dirPath, moduleName, ModuleName);
    
}

private void generateController(string dirPath, string moduleName, string ModuleName)
{
    string controllerPath = buildPath(dirPath, moduleName ~ ".controller.d");
    string controllerContent = format(DESTD_CONTROLLER_TEMPLATE,
        moduleName, moduleName,  // module %s.%s.controller;
        moduleName, ModuleName,  // import %s.%s.service;
        moduleName,              // @Controller("/%s")
        ModuleName,              // class %sController
        ModuleName, moduleName,  // private %sService %sService;
        ModuleName,              // this(%sService service)
        moduleName,              // this.%sService = service;
        moduleName,              // %sService.findAll()
        moduleName,              // %sService.findOne()
        moduleName,              // %sService.create()
        moduleName,              // %sService.update()
        moduleName);             // %sService.remove()
    write(controllerPath, controllerContent);
    writeln("  ✓ Controller: ", controllerPath);
}

private void generateService(string dirPath, string moduleName, string ModuleName)
{
    string servicePath = buildPath(dirPath, moduleName ~ ".service.d");
    string serviceContent = format(DESTD_SERVICE_TEMPLATE,
        moduleName, moduleName, ModuleName, ModuleName, ModuleName);
    write(servicePath, serviceContent);
    writeln("  ✓ Service: ", servicePath);
}

private void generateModule(string dirPath, string moduleName, string ModuleName)
{
    string modulePath = buildPath(dirPath, moduleName ~ ".mod.d");
    string moduleContent = format(DESTD_MODULE_TEMPLATE,
        moduleName, moduleName,  // module %s.%s.mod;
        moduleName, moduleName,  // import %s.%s.controller;
        moduleName, moduleName,  // import %s.%s.service;
        moduleName,              // /// Модуль %s
        ModuleName,              // @Module controllers: ["%sController"]
        ModuleName,              // @Module providers: ["%sService"]
        ModuleName,              // @Module exports: ["%sService"]
        ModuleName);             // class %sModule
    write(modulePath, moduleContent);
    writeln("  ✓ Module: ", modulePath);
}

