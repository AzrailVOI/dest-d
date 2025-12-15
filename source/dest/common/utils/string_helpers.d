module dest.common.utils.string_helpers;

import std.algorithm : startsWith, endsWith, countUntil;
import std.string : indexOf, lastIndexOf;

/// Обрезает строку до указанной длины
string truncate(string str, int maxLength, string suffix = "...")
{
    if (str.length <= maxLength) return str;
    return str[0..maxLength - suffix.length] ~ suffix;
}

/// Удаляет префикс из строки
string removePrefix(string str, string prefix)
{
    if (str.startsWith(prefix))
    {
        return str[prefix.length..$];
    }
    return str;
}

/// Удаляет суффикс из строки
string removeSuffix(string str, string suffix)
{
    if (str.endsWith(suffix))
    {
        return str[0..$-suffix.length];
    }
    return str;
}

/// Объединяет строки с разделителем
string join(string[] strings, string separator = ", ")
{
    if (strings.length == 0) return "";
    if (strings.length == 1) return strings[0];
    
    string result = strings[0];
    foreach (str; strings[1..$])
    {
        result ~= separator ~ str;
    }
    return result;
}

/// Разбивает строку на массив
string[] split(string str, string delimiter)
{
    string[] result;
    size_t start = 0;
    
    while (start < str.length)
    {
        int pos = cast(int)str.indexOf(delimiter, cast(int)start);
        if (pos == -1)
        {
            if (start < str.length)
                result ~= str[start..$];
            break;
        }
        result ~= str[start..cast(size_t)pos];
        start = cast(size_t)(pos + delimiter.length);
    }
    
    return result;
}


