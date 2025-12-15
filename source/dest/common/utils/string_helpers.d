module dest.common.utils.string_helpers;

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
    
    while (true)
    {
        size_t pos = str.indexOf(delimiter, start);
        if (pos == -1)
        {
            result ~= str[start..$];
            break;
        }
        result ~= str[start..pos];
        start = pos + delimiter.length;
    }
    
    return result;
}


