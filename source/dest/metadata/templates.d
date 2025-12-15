module dest.metadata.templates;

import std.meta;

/// Проверяет, есть ли у типа атрибут
template hasUDA(alias symbol, alias attribute)
{
    enum hasUDA = getUDAs!(symbol, attribute).length > 0;
}

/// Получает первый UDA указанного типа
template getFirstUDA(alias symbol, alias attribute)
{
    static if (hasUDA!(symbol, attribute))
    {
        alias getFirstUDA = getUDAs!(symbol, attribute)[0];
    }
    else
    {
        static assert(0, "No UDA of type " ~ attribute.stringof ~ " found");
    }
}


