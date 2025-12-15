module dest.common.validators.required;

import dest.common.validators.interface;
import std.format;

/// Валидатор для обязательных полей
class RequiredValidator : IValidator
{
    private string _fieldName;
    
    this(string fieldName = "")
    {
        this._fieldName = fieldName;
    }
    
    override bool validate(string value)
    {
        return value.length > 0;
    }
    
    override string getErrorMessage()
    {
        return _fieldName.length > 0 
            ? format("%s is required", _fieldName)
            : "Field is required";
    }
}


