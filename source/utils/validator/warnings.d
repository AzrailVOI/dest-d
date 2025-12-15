module utils.validator.warnings;

import std.stdio;
import std.string : split;
import utils.validator.reserved_words;

/// Выводит предупреждение, если имя содержит зарезервированное слово
void warnIfReservedWord(string name, string componentType = "компонент")
{
    string[] parts = name.split(".");
    foreach (part; parts)
    {
        if (isReservedWord(part))
        {
            stderr.writeln("Предупреждение: часть имени '%s' в '%s' является зарезервированным словом в D", part, name);
            stderr.writeln("  Рекомендуется использовать другое имя для ", componentType);
        }
    }
}


