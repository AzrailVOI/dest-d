module dest.router;

/// Роутер для Dest.d Framework
public import dest.router.router_core;
public import dest.router.controller_registration;

/// Регистрирует контроллер в роутере
void registerController(Router router, T)(T controller)
{
    ControllerRegistrator.registerController(router, controller);
}


