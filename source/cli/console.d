module cli.console;

/// Настройка консоли для корректного отображения UTF-8
void setupConsole()
{
    version(Windows)
    {
        import core.sys.windows.windows : SetConsoleOutputCP;
        // Устанавливаем кодовую страницу UTF-8 для вывода в консоль
        SetConsoleOutputCP(65001);
    }
}


