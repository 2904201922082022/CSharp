using System;

namespace Divisibility
{
    public class DivisibilityService
    {
        // Retorna verdadeiro se o número for divisível por 3, falso caso contrário
        public bool IsDivisibleByThree(int number)
        {
            return number % 3 == 0;
        }
    }
}
