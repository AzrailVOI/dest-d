module templates.types.entity;

/// Шаблон Entity
immutable string ENTITY_TEMPLATE = q{
module %s.entities.%s;

import vibe.data.serialization;

/// Entity %s для работы с БД
class %sEntity
{
    string id;
    
    // TODO: Добавить поля entity
    
    this()
    {
        import std.uuid : randomUUID;
        this.id = randomUUID().toString();
    }
}
};

