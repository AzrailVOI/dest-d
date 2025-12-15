module dest.http;

/// HTTP абстракции для Dest.d Framework
/// Скрывает детали реализации vibe.d

/// Экспортируем Json тип для использования в приложениях
public import vibe.vibe : Json;

/// Экспортируем Request и Response
public import dest.http.request;
public import dest.http.response : Response;

