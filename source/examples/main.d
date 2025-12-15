module examples.main;

import dest;
import examples.app_module;

/// Главный файл приложения
void main()
{
    // Печатаем информацию о фреймворке
    printFrameworkInfo();
    
    // Создаем корневой модуль
    auto appModule = new AppModule();
    
    // Создаем приложение через фабрику
    auto app = DestFactory.create(appModule, (ref config) {
        config.port = 3000;
        config.host = "0.0.0.0";
        config.enableLogging = true;
        config.globalPrefix = "/api";
        config.enableCors = true;
    });
    
    // Запускаем приложение
    app.listen();
}

