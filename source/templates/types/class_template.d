module templates.types.class_template;

/// Шаблон обычного класса
immutable string CLASS_TEMPLATE = q{
module %s.%s;

/// Класс %s
class %s
{
    // TODO: Добавить поля класса
    
    this()
    {
        // Конструктор
    }
    
    // TODO: Добавить методы
}
};

/// Шаблон интерфейса
immutable string INTERFACE_TEMPLATE = q{
module %s.%s;

/// Интерфейс %s
interface %s
{
    // TODO: Определить методы интерфейса
}
};

