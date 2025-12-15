module dest.common.validation;

import dest.common.exceptions;
import dest.common.validators;

/// Класс для валидации данных
class Validator
{
    /// Валидирует значение с помощью валидаторов
    static void validate(string value, IValidator[] validators)
    {
        foreach (validator; validators)
        {
            if (!validator.validate(value))
            {
                throw new BadRequestException(validator.getErrorMessage());
            }
        }
    }
    
    /// Валидирует обязательное поле
    static void validateRequired(string value, string fieldName = "")
    {
        auto validator = new RequiredValidator(fieldName);
        if (!validator.validate(value))
        {
            throw new BadRequestException(validator.getErrorMessage());
        }
    }
    
    /// Валидирует длину строки
    static void validateLength(string value, int min = 0, int max = int.max, string fieldName = "")
    {
        if (min > 0)
        {
            auto validator = new MinLengthValidator(min, fieldName);
            if (!validator.validate(value))
            {
                throw new BadRequestException(validator.getErrorMessage());
            }
        }
        
        if (max < int.max)
        {
            auto validator = new MaxLengthValidator(max, fieldName);
            if (!validator.validate(value))
            {
                throw new BadRequestException(validator.getErrorMessage());
            }
        }
    }
    
    /// Валидирует email
    static void validateEmail(string value)
    {
        auto validator = new EmailValidator();
        if (!validator.validate(value))
        {
            throw new BadRequestException(validator.getErrorMessage());
        }
    }
}
