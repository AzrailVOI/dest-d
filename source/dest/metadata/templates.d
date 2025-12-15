module dest.metadata.templates;

import std.meta;
import std.traits;

/// Проверяет, есть ли у типа атрибут
template hasUDA(alias symbol, alias attribute)
{
    // Пробуем getUDAs, если не работает - используем getAttributes для классов
    static if (is(symbol))
    {
        // Для типов (классов) используем __traits(getAttributes)
        enum hasUDA = hasAttribute!(symbol, attribute);
    }
    else
    {
        // Для символов используем getUDAs
        enum hasUDA = getUDAs!(symbol, attribute).length > 0;
    }
}

/// Вспомогательный шаблон для проверки атрибутов у типов
template hasAttribute(T, alias attribute)
{
    enum hasAttribute = hasAttributeImpl!(T, attribute, __traits(getAttributes, T));
}

template hasAttributeImpl(T, alias attribute, attrs...)
{
    static if (attrs.length == 0)
        enum hasAttributeImpl = false;
    else static if (is(typeof(attrs[0]) == attribute))
        enum hasAttributeImpl = true;
    else
        enum hasAttributeImpl = hasAttributeImpl!(T, attribute, attrs[1..$]);
}

/// Получает первый UDA указанного типа
template getFirstUDA(alias symbol, alias attribute)
{
    static if (is(symbol))
    {
        // Для типов используем __traits(getAttributes)
        alias getFirstUDA = getFirstAttributeImpl!(symbol, attribute, __traits(getAttributes, symbol));
    }
    else
    {
        // Для символов используем getUDAs
        static if (hasUDA!(symbol, attribute))
        {
            alias getFirstUDA = getUDAs!(symbol, attribute)[0];
        }
        else
        {
            static assert(0, "No UDA of type " ~ attribute.stringof ~ " found");
        }
    }
}

/// Вспомогательный шаблон для получения первого атрибута у типов
template getFirstAttributeImpl(T, alias attribute, attrs...)
{
    static if (attrs.length == 0)
        static assert(0, "No UDA of type " ~ attribute.stringof ~ " found");
    else static if (is(typeof(attrs[0]) == attribute))
        alias getFirstAttributeImpl = attrs[0];
    else
        alias getFirstAttributeImpl = getFirstAttributeImpl!(T, attribute, attrs[1..$]);
}


