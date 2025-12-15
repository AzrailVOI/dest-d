module dest.application.application;

import std.stdio;
import vibe.vibe;
import dest.module_system;
import dest.di_container;
import dest.router;
import dest.application.config;
import dest.application.server;
import dest.application.routes;

/// Главное приложение
class DestApplication
{
    private ModuleManager moduleManager;
    private URLRouter router;
    private ApplicationConfig config;
    private HTTPServerSettings serverSettings;
    
    this(ApplicationConfig config = ApplicationConfig.init)
    {
        this.config = config;
        this.moduleManager = new ModuleManager();
        this.router = new URLRouter();
        this.serverSettings = new HTTPServerSettings();
        
        ServerConfigurator.configure(serverSettings, config);
    }
    
    /// Регистрирует корневой модуль
    void registerRootModule(DestModule mod)
    {
        moduleManager.register(mod, "root");
    }
    
    /// Устанавливает глобальный префикс для всех маршрутов
    void setGlobalPrefix(string prefix)
    {
        config.globalPrefix = prefix;
    }
    
    /// Включает CORS
    void enableCors()
    {
        config.enableCors = true;
    }
    
    /// Настраивает маршруты
    private void setupRoutes()
    {
        Router destRouter = new Router(router);
        
        RouteConfigurator.setupGlobalPrefix(router, config, moduleManager);
        
        if (config.globalPrefix.length == 0)
        {
            moduleManager.registerAllRoutes(destRouter);
        }
        
        RouteConfigurator.setupHealthCheck(router);
        RouteConfigurator.setupCors(router, config);
    }
    
    /// Запускает приложение
    void listen()
    {
        setupRoutes();
        
        ServerConfigurator.printStartupInfo(
            config,
            cast(int)moduleManager.getModuleNames().length,
            cast(int)getGlobalContainer().getProviderNames().length
        );
        
        listenHTTP(serverSettings, router);
        runApplication();
    }
    
    /// Получает router (для тестирования)
    URLRouter getRouter()
    {
        return router;
    }
    
    /// Получает менеджер модулей
    ModuleManager getModuleManager()
    {
        return moduleManager;
    }
}


