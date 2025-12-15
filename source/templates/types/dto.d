module templates.types.dto;

/// Шаблон DTO (Data Transfer Object)
immutable string DTO_TEMPLATE = q{
module %s.dto.%s;

import vibe.data.serialization;

/// DTO для %s
struct %sDTO
{
    // TODO: Добавить поля DTO
    
    @optional string id;
    
    // Пример полей:
    // string name;
    // int age;
    // @optional string description;
}
};

