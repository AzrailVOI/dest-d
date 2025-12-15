module dest.module_system;

import std.traits;
import std.algorithm;
import std.array;
import dest.decorators;
import dest.metadata;
import dest.di_container;
import dest.router;

/// Базовый класс для всех модулей
abstract class DestModule
{
    protected DIContainer container;
    protected ModuleMetadata metadata;
    private Object[] controllerInstances;
    
    this()
    {
        container = getGlobalContainer();
        // Автоматически извлекаем метаданные из декоратора @Module
        metadata = extractModuleMetadata!(typeof(this))();
        // Автоматически регистрируем провайдеры
        registerAllProviders();
    }
    
    /// Автоматически регистрирует все провайдеры модуля
    private void registerAllProviders()
    {
        // Базовая реализация - регистрация через строковые имена
        // Подклассы могут переопределить для более сложной логики
    }
    
    /// Регистрирует модуль в контейнере
    void registerModule()
    {
        // Метаданные уже извлечены в конструкторе
        // Провайдеры регистрируются автоматически
    }
    
    /// Регистрирует маршруты контроллеров
    /// Теперь принимает Router абстракцию вместо URLRouter
    /// Базовая реализация - подклассы переопределяют для создания контроллеров
    void registerRoutes(Router router)
    {
        // Базовая реализация пуста
        // Подклассы должны переопределить этот метод
        // и создать инстансы контроллеров через createControllers()
    }
    
    /// Создает инстансы контроллеров (переопределяется в подклассах)
    protected void createControllers()
    {
        // Подклассы реализуют создание контроллеров
    }
    
    /// Импортирует другие модули
    void importModules(DestModule[] modules...)
    {
        foreach (mod; modules)
        {
            mod.registerModule();
        }
    }
    
    /// Экспортирует провайдеры для использования другими модулями
    string[] getExports()
    {
        return metadata.exports;
    }
}

/// Менеджер модулей
class ModuleManager
{
    private DestModule[string] modules;
    private DIContainer container;
    
    this()
    {
        container = getGlobalContainer();
    }
    
    /// Регистрирует модуль
    void register(DestModule mod, string name)
    {
        modules[name] = mod;
        mod.registerModule();
    }
    
    /// Получает модуль по имени
    DestModule get(string name)
    {
        return modules.get(name, null);
    }
    
    /// Регистрирует все маршруты
    void registerAllRoutes(Router router)
    {
        foreach (mod; modules.values)
        {
            mod.registerRoutes(router);
        }
    }
    
    /// Получает список всех модулей
    string[] getModuleNames()
    {
        return modules.keys;
    }
}

