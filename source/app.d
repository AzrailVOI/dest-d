module app;

import std.stdio;
import std.string : toLower;
import cli.console;
import cli.usage;
import cli.commands;

void main(string[] args)
{
    setupConsole();
    
    // Проверяем аргументы и флаги помощи
    if (args.length < 2 || args[1] == "--help" || args[1] == "-h" || args[1] == "help")
    {
        printUsage();
        return;
    }
    
    string command = args[1].toLower();
    
    try
    {
        if (!handleCommand(command, args))
        {
            // Неизвестная команда
            writeln("Ошибка: неизвестная команда '", command, "'");
            writeln();
            printUsage();
        }
    }
    catch (Exception e)
    {
        writeln();
        writeln("Ошибка: ", e.msg);
        writeln();
    }
}

