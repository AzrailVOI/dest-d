module templates.base.module_template;

/// Шаблон модуля в Dest.d стиле
immutable string DESTD_MODULE_TEMPLATE = q{
module %s.%s.mod;

import dest.decorators;
import dest.module_system;
import dest.router;
import %s.%s.controller;
import %s.%s.service;

/// Модуль %s
@Module(Module(
    [], // imports
    ["%sController"], // controllers
    ["%sService"], // providers
    ["%sService"] // exports
))
class %sModule : DestModule
{
}
};

