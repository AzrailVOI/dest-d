module templates.app.main;

/// Шаблон main.d
immutable string DESTD_MAIN_TEMPLATE = q{
module app;

import dest.application;
import app_module;

void main()
{
    // Печатаем информацию о фреймворке
    printFrameworkInfo();
    
    // Создаем корневой модуль
    auto appModule = new AppModule();
    
    // Создаем приложение через фабрику
    auto app = DestFactory.create(appModule, (ref config) {
        config.port = %s;
        config.host = "%s";
        config.enableLogging = %s;
        config.globalPrefix = "%s";
        config.enableCors = %s;
    });
    
    // Запускаем приложение
    app.listen();
}
};


