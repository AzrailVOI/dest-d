module dest.common.validators.length;

import dest.common.validators.interface;
import std.format;

/// Валидатор для минимальной длины
class MinLengthValidator : IValidator
{
    private int _minLength;
    private string _fieldName;
    
    this(int minLength, string fieldName = "")
    {
        this._minLength = minLength;
        this._fieldName = fieldName;
    }
    
    override bool validate(string value)
    {
        return value.length >= _minLength;
    }
    
    override string getErrorMessage()
    {
        return _fieldName.length > 0
            ? format("%s must be at least %d characters", _fieldName, _minLength)
            : format("Value must be at least %d characters", _minLength);
    }
}

/// Валидатор для максимальной длины
class MaxLengthValidator : IValidator
{
    private int _maxLength;
    private string _fieldName;
    
    this(int maxLength, string fieldName = "")
    {
        this._maxLength = maxLength;
        this._fieldName = fieldName;
    }
    
    override bool validate(string value)
    {
        return value.length <= _maxLength;
    }
    
    override string getErrorMessage()
    {
        return _fieldName.length > 0
            ? format("%s must be at most %d characters", _fieldName, _maxLength)
            : format("Value must be at most %d characters", _maxLength);
    }
}


