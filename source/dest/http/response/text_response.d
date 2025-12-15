module dest.http.response.text_response;

import vibe.vibe;
import dest.http.response.response_core;

/// Текстовые ответы
class TextResponse
{
    static void send(Response res, string text)
    {
        res.header("Content-Type", "text/plain; charset=UTF-8");
        res.raw.writeBody(text);
    }
    
    static void end(Response res)
    {
        res.raw.writeVoidBody();
    }
}

