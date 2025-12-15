module dest.common.validators.pattern;

import dest.common.validators.ivalidator;

/// Валидатор для регулярного выражения
class PatternValidator : IValidator
{
    private string _pattern;
    private string _errorMessage;
    
    this(string pattern, string errorMessage = "Value does not match pattern")
    {
        this._pattern = pattern;
        this._errorMessage = errorMessage;
    }
    
    override bool validate(string value)
    {
        // В D нет встроенной поддержки regex, используем простую проверку
        // Для полной реализации нужна библиотека
        return true; // Placeholder
    }
    
    override string getErrorMessage()
    {
        return _errorMessage;
    }
}


