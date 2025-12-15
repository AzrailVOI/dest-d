module cli.commands.generate_cmd;

import std.stdio;
import std.string : indexOf;
import object : Exception;
import utils.validator.name_validator;
import utils.validator.warnings;
import cli.commands.generate_components.parser;
import cli.commands.generate_components.generator;
import generators.template_type;

/// Обрабатывает команду generate
void handleGenerateCommand(string[] args)
{
    try
    {
        auto parsed = parseGenerateArgs(args);
        
        // Валидация имени компонента
        auto validation = validateComponentName(parsed.name);
        if (!validation[0])
        {
            writeln("Ошибка: ", validation[1]);
            return;
        }
        
        warnIfReservedWord(parsed.name, "компонент");
        
        writeln();
        writeln("Генерация компонента: ", getComponentDescription(parsed.componentType));
        writeln("Имя: ", parsed.name);
        writeln();
        
        generateComponent(parsed.componentType, parsed.name);
    }
    catch (Exception e)
    {
        if (e.msg.indexOf("Недостаточно аргументов") >= 0)
        {
            writeln("Ошибка: недостаточно аргументов для generate");
            writeln("Использование: dest generate <schematic> <name> [options]");
            writeln("Пример: dest g resource user");
        }
        else
        {
            writeln("Ошибка: ", e.msg);
            writeln();
            writeln("Доступные типы компонентов:");
            writeln("  module (mo), controller (co), service (s), resource (res)");
            writeln("  middleware (mi), guard (gu), interceptor (in), filter (f)");
            writeln("  pipe (pi), gateway (ga), resolver (r), provider (pr)");
            writeln("  class (cl), interface (i), decorator (d)");
        }
    }
}

