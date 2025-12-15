module generators.project_generator;

import std.stdio;
import std.file;
import std.path : buildPath;
import std.array : array;
import std.range : repeat;
import generators.config_reader;
import generators.project_file_templates;

/// Инициализирует новый проект
void initializeProject(string targetDir = null)
{
    // Получаем конфигурацию от пользователя
    ProjectConfig config = interactiveSetup();
    
    // Определяем целевую директорию
    string projectDir = targetDir is null ? getcwd() : targetDir;
    string sourceDir = buildPath(projectDir, "source");
    
    writeln();
    writeln('='.repeat(60).array);
    writeln("Создание проекта...");
    writeln('='.repeat(60).array);
    writeln();
    
    // Проверяем, не существует ли уже проект
    if (exists(buildPath(projectDir, "dub.json")))
    {
        write("В текущей директории уже есть dub.json. Перезаписать? [y/N]: ");
        if (!readYesNo(false))
        {
            throw new Exception("Инициализация отменена: проект уже существует");
        }
    }
    
    // Создаем структуру директорий
    if (!exists(sourceDir))
    {
        mkdirRecurse(sourceDir);
        writeln("✓ Создана директория: ", sourceDir);
    }
    
    // Генерируем файлы
    string dubJsonPath = buildPath(projectDir, "dub.json");
    std.file.write(dubJsonPath, generateDubJson(config, projectDir));
    writeln("✓ Создан файл: dub.json");
    
    string appDPath = buildPath(sourceDir, "app.d");
    std.file.write(appDPath, generateAppD(config));
    writeln("✓ Создан файл: source/app.d");
    
    string gitignorePath = buildPath(projectDir, ".gitignore");
    std.file.write(gitignorePath, generateGitignore());
    writeln("✓ Создан файл: .gitignore");
    
    string readmePath = buildPath(projectDir, "README.md");
    std.file.write(readmePath, generateReadme(config));
    writeln("✓ Создан файл: README.md");
    
    writeln();
    writeln('='.repeat(60).array);
    writeln("Проект успешно создан!");
    writeln('='.repeat(60).array);
    writeln();
    writeln("Следующие шаги:");
    writeln("  1. cd ", projectDir);
    writeln("  2. dub build          # Собрать проект");
    writeln("  3. dub run            # Запустить сервер");
    writeln();
    writeln("Для добавления модулей используйте:");
    writeln("  generator <module_name> [crud|empty]");
    writeln();
}

