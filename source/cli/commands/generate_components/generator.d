module cli.commands.generate_components.generator;

import std.stdio;
import generators.template_type;
import generators.destd;
import generators.advanced;

/// Генерирует компонент по типу
void generateComponent(ComponentType componentType, string name)
{
    final switch (componentType)
    {
        case ComponentType.MODULE:
        case ComponentType.RESOURCE:
            generateDestdModule(name);
            break;
            
        case ComponentType.CONTROLLER:
            writeln("Примечание: контроллер будет создан в составе модуля");
            generateDestdModule(name);
            break;
            
        case ComponentType.SERVICE:
            writeln("Примечание: сервис будет создан в составе модуля");
            generateDestdModule(name);
            break;
            
        case ComponentType.MIDDLEWARE:
            generateMiddleware(name);
            break;
            
        case ComponentType.GUARD:
            generateGuard(name);
            break;
            
        case ComponentType.INTERCEPTOR:
            generateInterceptor(name);
            break;
            
        case ComponentType.FILTER:
            generateFilter(name);
            break;
            
        case ComponentType.PIPE:
            generatePipe(name);
            break;
            
        case ComponentType.GATEWAY:
            generateGateway(name);
            break;
            
        case ComponentType.RESOLVER:
            generateResolver(name);
            break;
            
        case ComponentType.PROVIDER:
            generateProvider(name);
            break;
            
        case ComponentType.CLASS:
            generateClass(name);
            break;
            
        case ComponentType.INTERFACE:
            generateInterface(name);
            break;
            
        case ComponentType.DECORATOR:
            generateDecorator(name);
            break;
    }
}

