module cli.commands.generate_components.parser;

import std.string : toLower;
import generators.template_type;

/// Парсит аргументы команды generate
struct GenerateCommandArgs
{
    string schematic;
    string name;
    TemplateType templateType;
    ComponentType componentType;
}

/// Парсит аргументы команды generate
GenerateCommandArgs parseGenerateArgs(string[] args)
{
    GenerateCommandArgs result;
    
    if (args.length < 4)
    {
        throw new Exception("Недостаточно аргументов");
    }
    
    result.schematic = args[2];
    result.name = args[3];
    
    // Определяем тип шаблона из опций
    result.templateType = TemplateType.CRUD;
    if (args.length > 4)
    {
        foreach (arg; args[4..$])
        {
            if (arg == "--empty")
                result.templateType = TemplateType.EMPTY;
        }
    }
    
    // Парсим тип компонента
    result.componentType = parseComponentType(result.schematic);
    
    return result;
}

