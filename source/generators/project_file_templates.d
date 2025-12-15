module generators.project_file_templates;

import std.format : format;
import std.string : replace;
import std.path : relativePath, dirName;
import std.file : getcwd;
import generators.config_reader;

/// Генерирует dub.json для нового проекта
string generateDubJson(ProjectConfig config, string projectDir = null)
{
    // Заменяем точки в имени проекта на дефисы для валидного имени пакета DUB
    string packageName = config.projectName;
    packageName = replace(packageName, ".", "-");
    packageName = replace(packageName, "_", "-");
    
    // Определяем путь к генератору (где находится dest-d.json) относительно проекта
    // Предполагаем, что генератор находится на один уровень выше проекта
    // Это стандартное расположение: U:\dev\D\vibed-nest-generator и U:\dev\D\testdest
    string generatorDir = "../vibed-nest-generator";
    
    // Если projectDir указан, пытаемся вычислить относительный путь
    if (projectDir !is null)
    {
        string currentDir = getcwd();
        // Простая проверка: если проекты в одной родительской директории
        // Используем стандартный путь
    }
    
    string dubTemplate = `{
	"name": "%s",
	"description": "%s",
	"authors": [
		"%s"
	],
	"license": "%s",
	"dependencies": {
		"vibe-d": "~>0.9.0",
		"dest-d": {"path": "%s"}
	},
	"versions": ["VibeDefaultMain"]
}`;
    
    return format(dubTemplate, 
        packageName,
        config.projectDescription,
        config.author,
        config.license,
        generatorDir
    );
}

/// Генерирует app.d для нового проекта
string generateAppD(ProjectConfig config)
{
    string appTemplate = `module app;

import dest;
import dest.module_system;
import dest.application;

/// Корневой модуль приложения
class AppModule : DestModule
{
    this()
    {
        super();
        
        // Метаданные модуля
        metadata.moduleName = "AppModule";
        metadata.imports = [];
    }
    
    override void registerRoutes(Router router)
    {
        // Корневой маршрут
        router.get("/", (Request req, Response res) {
            import dest.http;
            
            Json response = Json.emptyObject;
            response["message"] = "Welcome to %s!";
            response["version"] = "1.0.0";
            res.json(response);
        });
    }
}

void main()
{
    import dest.application;
    
    // Создаем приложение с конфигурацией
    auto app = DestFactory.create(new AppModule(), (ref ApplicationConfig config) {
        config.port = %d;
        config.host = "%s";
        config.globalPrefix = "/api";  // Глобальный префикс для всех маршрутов
        config.enableCors = true;      // Включить CORS
        config.enableLogging = %s;     // Логирование
    });
    
    // Запускаем сервер
    app.listen();
}
`;
    
    return format(appTemplate,
        config.projectName,
        config.serverPort,
        config.serverHost,
        config.enableLogging ? "true" : "false"
    );
}

/// Генерирует .gitignore
string generateGitignore()
{
    return `.dub
dub.selections.json
*.exe
*.o
*.obj
*.lst
*.a
*.lib
*.so
*.dylib
*.dll
*.pdb
__test__*__
*.swp
*.swo
*~
.DS_Store
`;
}

/// Генерирует README.md для проекта
string generateReadme(ProjectConfig config)
{
    string readmeTemplate = `# %s

%s

## Быстрый старт

### Требования
- DMD/LDC компилятор
- DUB package manager

### Установка зависимостей
` ~ "```bash\n" ~ `dub build
` ~ "```\n\n" ~ `### Запуск сервера
` ~ "```bash\n" ~ `dub run
` ~ "```\n\n" ~ `Сервер будет доступен по адресу: http://%s:%d

## API Endpoints

- GET / - Главная страница
- GET /api/health - Health check

## Добавление модулей

Используйте генератор для создания новых модулей:

` ~ "```bash\n" ~ `# CRUD модуль
generator user crud

# Пустой модуль
generator settings empty
` ~ "```\n\n" ~ `## Автор

%s

## Лицензия

%s
`;
    
    return format(readmeTemplate,
        config.projectName,
        config.projectDescription,
        config.serverHost == "0.0.0.0" ? "localhost" : config.serverHost,
        config.serverPort,
        config.author,
        config.license
    );
}

