module templates.base.service;

/// Шаблон сервиса в Dest.d стиле
immutable string DESTD_SERVICE_TEMPLATE = q{
module %s.%s.service;

import dest.decorators;
import dest.common;

@Injectable
class %sService
{
    /// Получить все элементы
    string findAll()
    {
        Json response = Json.emptyArray;
        response ~= Json(["id": Json(1), "name": Json("Item 1")]);
        response ~= Json(["id": Json(2), "name": Json("Item 2")]);
        return response.toString();
    }
    
    /// Получить один элемент по ID
    string findOne(string id)
    {
        Json response = Json.emptyObject;
        response["id"] = id;
        response["name"] = "%s " ~ id;
        return response.toString();
    }
    
    /// Создать новый элемент
    string create(Json data)
    {
        import std.datetime;
        Json response = data.clone();
        response["id"] = 1;
        response["createdAt"] = Clock.currTime.toISOExtString();
        return response.toString();
    }
    
    /// Обновить элемент по ID
    string update(string id, Json data)
    {
        import std.datetime;
        Json response = data.clone();
        response["id"] = id;
        response["updatedAt"] = Clock.currTime.toISOExtString();
        return response.toString();
    }
    
    /// Удалить элемент по ID
    void remove(string id)
    {
        import std.stdio;
        writeln("%s ", id, "removed");
    }
}
};

