module dest.decorators.module_decorator;

/// Декоратор для модуля
struct Module
{
    /// Импортируемые модули
    string[] imports;
    
    /// Контроллеры модуля
    string[] controllers;
    
    /// Провайдеры (сервисы) модуля
    string[] providers;
    
    /// Экспортируемые провайдеры
    string[] exports;
}

/// Декоратор для Injectable сервиса
struct Injectable
{
    /// Scope провайдера (singleton, request, transient)
    string scope_ = "singleton";
}

/// Глобальный префикс
struct GlobalPrefix
{
    string prefix;
}

