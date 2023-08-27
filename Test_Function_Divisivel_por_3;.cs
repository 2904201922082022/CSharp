using Xunit;
using Divisibility;

namespace Divisibility.Tests
{
    public class DivisibilityTests
    {
        // Instancia a classe que contém a função a ser testada
        private readonly DivisibilityService _divisibilityService;

        // Construtor que inicializa a instância
        public DivisibilityTests()
        {
            _divisibilityService = new DivisibilityService();
        }

        // Método que usa o atributo [Fact] para indicar que é um teste
        [Fact]
        public void IsDivisibleByThree_WithDivisibleNumber_ReturnsTrue()
        {
            // Arrange: define os dados de entrada e o resultado esperado
            int input = 9;
            bool expected = true;

            // Act: invoca a função com os dados de entrada
            bool actual = _divisibilityService.IsDivisibleByThree(input);

            // Assert: verifica se o resultado obtido é igual ao esperado
            Assert.Equal(expected, actual);
        }

        // Outro método de teste com um número não divisível por 3
        [Fact]
        public void IsDivisibleByThree_WithNonDivisibleNumber_ReturnsFalse()
        {
            // Arrange
            int input = 10;
            bool expected = false;

            // Act
            bool actual = _divisibilityService.IsDivisibleByThree(input);

            // Assert
            Assert.Equal(expected, actual);
        }
    }
}
