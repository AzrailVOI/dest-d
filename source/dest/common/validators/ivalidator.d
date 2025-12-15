module dest.common.validators.ivalidator;

import dest.common.exceptions;

/// Интерфейс для валидатора
interface IValidator
{
    /// Валидирует значение
    bool validate(string value);
    
    /// Возвращает сообщение об ошибке
    string getErrorMessage();
}


