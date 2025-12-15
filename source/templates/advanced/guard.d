module templates.advanced.guard;

/// Шаблон guard
immutable string GUARD_TEMPLATE = q{
module %s.%s.guard;

import dest.http;

/// Guard для проверки авторизации
class %sGuard
{
    /// Проверяет, разрешен ли доступ
    bool canActivate(Request req, Response res)
    {
        // TODO: Реализовать логику проверки доступа
        
        // Пример: проверка токена
        auto authHeader = req.getHeader("Authorization");
        if (authHeader.length == 0)
        {
            res.status(401).json(`{"error":"Unauthorized"}`);
            return false;
        }
        
        // Проверка токена
        // if (!validateToken(authHeader)) return false;
        
        return true;
    }
}
};


