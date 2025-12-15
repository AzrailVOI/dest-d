module templates.types.provider;

/// Шаблон Provider
immutable string PROVIDER_TEMPLATE = q{
module %s.%s.provider;

/// Provider %s
class %sProvider
{
    // TODO: Реализовать DI провайдер
    
    this()
    {
        // Инициализация провайдера
    }
    
    // Методы провайдера
}
};

/// Шаблон Decorator
immutable string DECORATOR_TEMPLATE = q{
module %s.decorators.%s;

import std.traits;

/// Декоратор %s
template %s(alias func)
{
    auto %s(Args...)(Args args)
    {
        // TODO: Логика перед вызовом функции
        
        // Вызов оригинальной функции
        auto result = func(args);
        
        // TODO: Логика после вызова функции
        
        return result;
    }
}

/// Пример использования:
/// @%s
/// void myFunction() { }
};

