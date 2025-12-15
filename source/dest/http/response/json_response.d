module dest.http.response.json_response;

import vibe.vibe;
import dest.http.response.response_core;

/// JSON ответы
class JsonResponse
{
    static void json(Response res, Json data)
    {
        res.header("Content-Type", "application/json; charset=UTF-8");
        res.raw.writeBody(data.toString());
    }
    
    static void json(Response res, string data)
    {
        res.header("Content-Type", "application/json; charset=UTF-8");
        res.raw.writeBody(data);
    }
    
    static void json(T)(Response res, T data)
    {
        import std.conv : to;
        res.header("Content-Type", "application/json; charset=UTF-8");
        
        static if (is(T == string))
        {
            res.raw.writeBody(data);
        }
        else static if (is(T == int) || is(T == long) || is(T == float) || is(T == double))
        {
            res.raw.writeBody(to!string(data));
        }
        else
        {
            Json jsonObj = Json(data);
            res.raw.writeBody(jsonObj.toString());
        }
    }
}


