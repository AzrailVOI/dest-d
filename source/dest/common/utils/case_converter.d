module dest.common.utils.case_converter;

/// Преобразует строку в camelCase
string toCamelCase(string input)
{
    if (input.length == 0) return input;
    
    string result = input[0].toLower().to!string;
    bool nextUpper = false;
    
    foreach (char c; input[1..$])
    {
        if (c == '_' || c == '-' || c == ' ')
        {
            nextUpper = true;
        }
        else if (nextUpper)
        {
            result ~= c.toUpper().to!string;
            nextUpper = false;
        }
        else
        {
            result ~= c.toLower().to!string;
        }
    }
    
    return result;
}

/// Преобразует строку в PascalCase
string toPascalCase(string input)
{
    if (input.length == 0) return input;
    
    string camel = toCamelCase(input);
    return camel[0].toUpper().to!string ~ camel[1..$];
}

/// Преобразует строку в snake_case
string toSnakeCase(string input)
{
    string result = "";
    bool first = true;
    
    foreach (char c; input)
    {
        if (c >= 'A' && c <= 'Z')
        {
            if (!first) result ~= "_";
            result ~= c.toLower().to!string;
        }
        else if (c == '-' || c == ' ')
        {
            result ~= "_";
        }
        else
        {
            result ~= c;
        }
        first = false;
    }
    
    return result;
}

/// Преобразует строку в kebab-case
string toKebabCase(string input)
{
    string result = "";
    bool first = true;
    
    foreach (char c; input)
    {
        if (c >= 'A' && c <= 'Z')
        {
            if (!first) result ~= "-";
            result ~= c.toLower().to!string;
        }
        else if (c == '_' || c == ' ')
        {
            result ~= "-";
        }
        else
        {
            result ~= c;
        }
        first = false;
    }
    
    return result;
}


