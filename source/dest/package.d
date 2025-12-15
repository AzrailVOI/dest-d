module dest;

/// Публичный API Dest.d Framework
/// Импортируйте этот модуль для доступа ко всему фреймворку

// Core модули
public import dest.decorators;
public import dest.metadata;
public import dest.di_container;
public import dest.module_system;
public import dest.application;

// HTTP абстракции
public import dest.http;
public import dest.router;

// Common модули (аналог @nestjs/common)
public import dest.common;

/// Версия фреймворка
enum DESTD_VERSION = "1.0.0";

/// Информация о фреймворке
void printFrameworkInfo()
{
    import std.stdio;
    
    writeln("╔════════════════════════════════════════════════════════════╗");
    writeln("║                 Dest.d Framework v", DESTD_VERSION, "                  ║");
    writeln("║          Modern async web framework for D                ║");
    writeln("╚════════════════════════════════════════════════════════════╝");
}

