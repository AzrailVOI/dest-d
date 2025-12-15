module utils.validator.name_validator;

import std.string : toLower;
import std.format : format;
import std.typecons : tuple, Tuple;
import utils.validator.reserved_words;

/// Проверяет, является ли имя модуля валидным
/// Возвращает (валидность, сообщение об ошибке)
Tuple!(bool, string) validateModuleName(string name)
{
    if (name.length == 0)
    {
        return tuple(false, "Имя модуля не может быть пустым");
    }
    
    // Проверка на зарезервированные слова
    if (isReservedWord(name))
    {
        return tuple(false, format("Имя '%s' является зарезервированным словом в D", name));
    }
    
    // Проверка первого символа
    char firstChar = name[0];
    if (!((firstChar >= 'a' && firstChar <= 'z') || 
          (firstChar >= 'A' && firstChar <= 'Z') || 
          firstChar == '_'))
    {
        return tuple(false, "Имя модуля должно начинаться с буквы или подчеркивания");
    }
    
    // Проверка остальных символов
    foreach (char c; name)
    {
        if (!((c >= 'a' && c <= 'z') || 
              (c >= 'A' && c <= 'Z') || 
              (c >= '0' && c <= '9') || 
              c == '_' || 
              c == '.'))
        {
            return tuple(false, format("Имя модуля содержит недопустимый символ: '%s'", c));
        }
    }
    
    // Проверка на точки
    if (name[0] == '.' || name[$-1] == '.')
    {
        return tuple(false, "Имя модуля не может начинаться или заканчиваться точкой");
    }
    
    import std.algorithm : canFind;
    if (canFind(name, ".."))
    {
        return tuple(false, "Имя модуля не может содержать двойные точки");
    }
    
    return tuple(true, "");
}

/// Проверяет имя компонента
Tuple!(bool, string) validateComponentName(string name)
{
    import std.string : split;
    string[] parts = name.split(".");
    string baseName = parts[$-1];
    
    return validateModuleName(baseName);
}


