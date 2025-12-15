module dest.metadata.controller;

import std.traits;
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
        static if (is(typeof(__traits(getMember, T, memberName)) == function))
        {
            {
                alias member = __traits(getMember, T, memberName);
                
                // GET
                static if (hasUDA!(member, Get))
                {
                    enum get = getFirstUDA!(member, Get);
                    RouteMetadata route;
                    route.method = "GET";
                    route.path = get.path;
                    route.handler = memberName;
                    meta.routes ~= route;
                }
                
                // POST
                static if (hasUDA!(member, Post))
                {
                    enum post = getFirstUDA!(member, Post);
                    RouteMetadata route;
                    route.method = "POST";
                    route.path = post.path;
                    route.handler = memberName;
                    meta.routes ~= route;
                }
                
                // PUT
                static if (hasUDA!(member, Put))
                {
                    enum put = getFirstUDA!(member, Put);
                    RouteMetadata route;
                    route.method = "PUT";
                    route.path = put.path;
                    route.handler = memberName;
                    meta.routes ~= route;
                }
                
                // DELETE
                static if (hasUDA!(member, Delete))
                {
                    enum del = getFirstUDA!(member, Delete);
                    RouteMetadata route;
                    route.method = "DELETE";
                    route.path = del.path;
                    route.handler = memberName;
                    meta.routes ~= route;
                }
                
                // PATCH
                static if (hasUDA!(member, Patch))
                {
                    enum patch = getFirstUDA!(member, Patch);
                    RouteMetadata route;
                    route.method = "PATCH";
                    route.path = patch.path;
                    route.handler = memberName;
                    meta.routes ~= route;
                }
            }
        }
    }
    
    return meta;
}


