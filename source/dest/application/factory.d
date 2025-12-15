module dest.application.factory;

import dest.application;
import dest.module_system;

/// Фабрика приложений
class DestFactory
{
    /// Создает приложение с корневым модулем
    static DestApplication create(DestModule rootModule, ApplicationConfig config = ApplicationConfig.init)
    {
        auto app = new DestApplication(config);
        app.registerRootModule(rootModule);
        return app;
    }
    
    /// Создает приложение с настройками из функции
    static DestApplication create(DestModule rootModule, void delegate(ref ApplicationConfig) configure)
    {
        ApplicationConfig config;
        configure(config);
        return create(rootModule, config);
    }
}


