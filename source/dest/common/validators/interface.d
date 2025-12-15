module dest.common.validators.interface;

import dest.common.exceptions;

/// Интерфейс для валидатора
interface IValidator
{
    /// Валидирует значение
    bool validate(string value);
    
    /// Возвращает сообщение об ошибке
    string getErrorMessage();
}


