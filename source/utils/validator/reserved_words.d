module utils.validator.reserved_words;

import std.array;
import std.algorithm : canFind;

/// Список зарезервированных слов в D
immutable string[] RESERVED_WORDS = [
    "abstract", "alias", "align", "asm", "assert", "auto",
    "body", "bool", "break", "byte",
    "case", "cast", "catch", "cdouble", "cent", "cfloat", "char", "class", "const", "continue", "creal",
    "dchar", "debug", "default", "delegate", "delete", "deprecated", "do", "double",
    "else", "enum", "export", "extern",
    "false", "final", "finally", "float", "for", "foreach", "foreach_reverse", "function",
    "goto",
    "idouble", "if", "ifloat", "immutable", "import", "in", "inout", "int", "interface", "invariant", "ireal", "is",
    "lazy", "long",
    "macro", "mixin", "module",
    "new", "nothrow", "null",
    "out", "override",
    "package", "pragma", "private", "protected", "public", "pure",
    "real", "ref", "return",
    "scope", "shared", "short", "static", "struct", "super", "switch", "synchronized",
    "template", "this", "throw", "true", "try", "typedef", "typeid", "typeof",
    "ubyte", "ucent", "uint", "ulong", "union", "unittest", "ushort",
    "version", "void", "volatile",
    "wchar", "while", "with",
    "__FILE__", "__FUNCTION__", "__LINE__", "__MODULE__", "__PRETTY_FUNCTION__", "__TIMESTAMP__", "__VENDOR__", "__VERSION__"
];

/// Проверяет, является ли слово зарезервированным
bool isReservedWord(string word)
{
    import std.string : toLower;
    return canFind(RESERVED_WORDS, word.toLower());
}


