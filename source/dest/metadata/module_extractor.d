module dest.metadata.module_extractor;

import dest.decorators;
import dest.metadata.structures;
import dest.metadata.templates;

/// Извлекает метаданные модуля
ModuleMetadata extractModuleMetadata(T)()
{
    ModuleMetadata meta;
    meta.moduleName = T.stringof;
    
    static if (hasUDA!(T, Module))
    {
        enum mod = getFirstUDA!(T, Module);
        meta.imports = mod.imports.dup;
        meta.controllers = mod.controllers.dup;
        meta.providers = mod.providers.dup;
        meta.exports = mod.exports.dup;
    }
    
    return meta;
}


