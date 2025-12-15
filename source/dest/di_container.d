module dest.di_container;

import std.traits;
import std.typecons : Nullable;
import dest.metadata;

/// Dependency Injection контейнер
class DIContainer
{
    private Object[string] singletons;
    private ProviderMetadata[string] providers;
    
    /// Регистрирует провайдер
    void register(T)(string name = T.stringof)
    {
        auto meta = extractProviderMetadata!T();
        providers[name] = meta;
    }
    
    /// Получает или создает инстанс провайдера
    T resolve(T)(string name = T.stringof)
    {
        // Проверяем, есть ли уже singleton
        if (name in singletons)
        {
            return cast(T) singletons[name];
        }
        
        // Создаем новый инстанс
        auto instance = new T();
        
        // Если scope = singleton, сохраняем
        if (name in providers && providers[name].scope_ == "singleton")
        {
            singletons[name] = instance;
        }
        
        return instance;
    }
    
    /// Создает инстанс с внедрением зависимостей
    T create(T, Args...)(Args args)
    {
        return new T(args);
    }
    
    /// Проверяет, зарегистрирован ли провайдер
    bool has(string name)
    {
        return (name in providers) !is null;
    }
    
    /// Очищает контейнер
    void clear()
    {
        singletons.clear();
        providers.clear();
    }
    
    /// Получает все зарегистрированные провайдеры
    string[] getProviderNames()
    {
        return providers.keys;
    }
}

/// Глобальный DI контейнер
private __gshared DIContainer _globalContainer;

/// Получает глобальный DI контейнер
DIContainer getGlobalContainer()
{
    if (_globalContainer is null)
    {
        _globalContainer = new DIContainer();
    }
    return _globalContainer;
}

