module cli.commands.router;

import std.string : toLower;
import cli.commands.module_cmd;
import cli.commands.generate_cmd;
import generators.project_generator;

/// Обрабатывает команду init
void handleInitCommand()
{
    initializeProject();
}

/// Обрабатывает команду (роутинг)
bool handleCommand(string command, string[] args)
{
    switch (command)
    {
        case "init":
            handleInitCommand();
            return true;
            
        case "module":
            handleModuleCommand(args);
            return true;
            
        case "generate", "g":
            handleGenerateCommand(args);
            return true;
            
        default:
            return false;
    }
}

