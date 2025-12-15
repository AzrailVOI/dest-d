module cli.commands.module_cmd;

import std.stdio;
import utils.validator.name_validator;
import utils.validator.warnings;
import generators.destd;

/// Обрабатывает команду module
void handleModuleCommand(string[] args)
{
    if (args.length < 3)
    {
        writeln("Ошибка: укажите имя модуля");
        writeln("Использование: dest module <module_name>");
        writeln("Пример: dest module user");
        return;
    }
    
    string moduleName = args[2];
    
    // Валидация имени модуля
    auto validation = validateModuleName(moduleName);
    if (!validation[0])
    {
        writeln("Ошибка: ", validation[1]);
        return;
    }
    
    warnIfReservedWord(moduleName, "модуль");
    generateDestdModule(moduleName);
}

