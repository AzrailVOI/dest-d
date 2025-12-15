module dest.common.validators.email;

import dest.common.validators.interface;

/// Валидатор для email
class EmailValidator : IValidator
{
    override bool validate(string value)
    {
        // Простая проверка email
        return value.indexOf('@') > 0 && value.indexOf('.') > value.indexOf('@');
    }
    
    override string getErrorMessage()
    {
        return "Invalid email format";
    }
}


