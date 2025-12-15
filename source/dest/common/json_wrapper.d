module dest.common.json_wrapper;

import vibe.vibe;

/// Абстракция для работы с JSON
/// Скрывает детали реализации vibe.d Json
alias Json = vibe.vibe.Json;

/// JSON утилиты
struct JsonUtil
{
    /// Создает пустой объект
    static Json emptyObject()
    {
        return Json.emptyObject;
    }
    
    /// Создает пустой массив
    static Json emptyArray()
    {
        return Json.emptyArray;
    }
    
    /// Создает JSON из значения
    static Json from(T)(T value)
    {
        return Json(value);
    }
    
    /// Создает JSON объект из пары ключ-значение
    static Json object(string key, Json value)
    {
        Json obj = Json.emptyObject;
        obj[key] = value;
        return obj;
    }
}


