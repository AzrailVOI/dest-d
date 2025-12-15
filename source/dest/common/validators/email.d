module dest.common.validators.email;

import std.string : indexOf;
import dest.common.validators.ivalidator;

/// Валидатор для email
class EmailValidator : IValidator
{
    override bool validate(string value)
    {
        // Простая проверка email
        int atPos = cast(int)value.indexOf('@');
        int dotPos = cast(int)value.indexOf('.');
        return atPos > 0 && dotPos > atPos;
    }
    
    override string getErrorMessage()
    {
        return "Invalid email format";
    }
}


