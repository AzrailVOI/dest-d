module dest.application.server;

import std.stdio;
import vibe.vibe;
import dest.application.config;

/// Настройка сервера
class ServerConfigurator
{
    static void configure(HTTPServerSettings settings, ApplicationConfig config)
    {
        settings.port = config.port;
        settings.bindAddresses = [config.host];
        
        if (config.enableLogging)
        {
            setLogLevel(LogLevel.info);
        }
    }
    
    static void printStartupInfo(ApplicationConfig config, int moduleCount, int providerCount)
    {
        writeln();
        writeln("╔════════════════════════════════════════════════════════════╗");
        writeln("║             Dest.d Application Starting...                ║");
        writeln("╚════════════════════════════════════════════════════════════╝");
        writeln();
        writefln("🚀 Server running on: http://%s:%s", config.host, config.port);
        
        if (config.globalPrefix.length > 0)
        {
            writefln("🌐 Global prefix: %s", config.globalPrefix);
        }
        
        writefln("📦 Modules: %s", moduleCount);
        writefln("🔧 DI Providers: %s", providerCount);
        writeln();
        writeln("✨ Application successfully started!");
        writeln();
    }
}


