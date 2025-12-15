module dest.metadata.controller;

import std.traits;
import std.meta;
import dest.decorators;
import dest.metadata.structures;
import dest.metadata.templates;

/// Извлекает метаданные контроллера
ControllerMetadata extractControllerMetadata(T)()
{
    ControllerMetadata meta;
    
    static if (hasUDA!(T, Controller))
    {
        enum controller = getFirstUDA!(T, Controller);
        meta.basePath = controller.path;
    }
    
    // Извлекаем маршруты из методов
    static foreach (memberName; __traits(allMembers, T))
    {
        // Пропускаем конструкторы и специальные методы
        static if (memberName != "this" && memberName != "opAssign" && memberName != "toString")
        {
            // Проверяем, является ли член методом
            static if (__traits(compiles, { alias member = __traits(getMember, T, memberName); }))
            {
                // GET
                static if (hasMethodUDA!(T, memberName, Get))
                {
                    RouteMetadata route;
                    route.method = "GET";
                    route.path = getMethodUDA!(T, memberName, Get).path;
                    route.handler = memberName;
                    meta.routes ~= route;
                }
                
                // POST
                static if (hasMethodUDA!(T, memberName, Post))
                {
                    RouteMetadata route;
                    route.method = "POST";
                    route.path = getMethodUDA!(T, memberName, Post).path;
                    route.handler = memberName;
                    meta.routes ~= route;
                }
                
                // PUT
                static if (hasMethodUDA!(T, memberName, Put))
                {
                    RouteMetadata route;
                    route.method = "PUT";
                    route.path = getMethodUDA!(T, memberName, Put).path;
                    route.handler = memberName;
                    meta.routes ~= route;
                }
                
                // DELETE
                static if (hasMethodUDA!(T, memberName, Delete))
                {
                    RouteMetadata route;
                    route.method = "DELETE";
                    route.path = getMethodUDA!(T, memberName, Delete).path;
                    route.handler = memberName;
                    meta.routes ~= route;
                }
                
                // PATCH
                static if (hasMethodUDA!(T, memberName, Patch))
                {
                    RouteMetadata route;
                    route.method = "PATCH";
                    route.path = getMethodUDA!(T, memberName, Patch).path;
                    route.handler = memberName;
                    meta.routes ~= route;
                }
            }
        }
    }
    
    return meta;
}

/// Проверяет наличие UDA у метода класса
template hasMethodUDA(T, string memberName, alias attribute)
{
    enum hasMethodUDA = hasMethodUDAImpl!(T, memberName, attribute, __traits(getAttributes, T, memberName));
}

template hasMethodUDAImpl(T, string memberName, alias attribute, attrs...)
{
    static if (attrs.length == 0)
        enum hasMethodUDAImpl = false;
    else static if (is(typeof(attrs[0]) == attribute))
        enum hasMethodUDAImpl = true;
    else
        enum hasMethodUDAImpl = hasMethodUDAImpl!(T, memberName, attribute, attrs[1..$]);
}

/// Получает первый UDA у метода класса
template getMethodUDA(T, string memberName, alias attribute)
{
    alias getMethodUDA = getMethodUDAImpl!(T, memberName, attribute, __traits(getAttributes, T, memberName));
}

template getMethodUDAImpl(T, string memberName, alias attribute, attrs...)
{
    static if (attrs.length == 0)
        static assert(0, "No UDA of type " ~ attribute.stringof ~ " found on method " ~ memberName);
    else static if (is(typeof(attrs[0]) == attribute))
        alias getMethodUDAImpl = attrs[0];
    else
        alias getMethodUDAImpl = getMethodUDAImpl!(T, memberName, attribute, attrs[1..$]);
}


