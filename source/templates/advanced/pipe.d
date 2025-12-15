module templates.advanced.pipe;

/// Шаблон pipe (валидация данных)
immutable string PIPE_TEMPLATE = q{
module %s.%s.pipe;

import dest.common.validation;
import dest.common.exceptions;
import std.exception : enforce;

/// Pipe для валидации и трансформации данных
class %sPipe
{
    /// Трансформирует и валидирует данные
    T transform(T)(T value)
    {
        // TODO: Реализовать логику валидации
        
        // Пример валидации
        static if (is(T == string))
        {
            enforce(value.length > 0, "Значение не может быть пустым");
        }
        
        return value;
    }
    
    /// Валидирует JSON объект
    void validate(Json data, string[] requiredFields)
    {
        foreach (field; requiredFields)
        {
            if (!(field in data))
            {
                throw new BadRequestException(format("Поле '%s' обязательно", field));
            }
        }
    }
}
};


