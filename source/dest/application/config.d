module dest.application.config;

/// Конфигурация приложения
struct ApplicationConfig
{
    ushort port = 8080;
    string host = "0.0.0.0";
    bool enableLogging = true;
    string globalPrefix = "";
    bool enableCors = false;
}


