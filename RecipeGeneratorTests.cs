using NUnit.Framework;
using System.IO;
using System.Linq;

namespace RecipeGenerator.Tests
{
    [TestFixture]
    public class RecipeGeneratorTests
    {
        // Define uma variável para armazenar o caminho do arquivo CSV com os dados das receitas
        private string csvPath = "recipes.csv";
        
        // Define uma variável para armazenar o objeto da classe RecipeGenerator
        private RecipeGenerator generator;

        // Define um método que é executado antes de cada teste, usando o atributo [SetUp]
        [SetUp]
        public void SetUp()
        {
            // Instancia o objeto da classe RecipeGenerator
            generator = new RecipeGenerator();
        }

        // Define um método que é executado depois de cada teste, usando o atributo [TearDown]
        [TearDown]
        public void TearDown()
        {
            // Libera os recursos usados pelo objeto da classe RecipeGenerator
            generator.Dispose();
        }

        // Define um método que testa se a função GenerateRecipe retorna uma receita válida, usando o atributo [Test]
        [Test]
        public void GenerateRecipe_WithValidDataset_ReturnsValidRecipe()
        {
            // Lê os dados das receitas a partir do arquivo CSV
            var recipes = File.ReadAllLines(csvPath)
                              .Skip(1) // Pula a primeira linha com os nomes das colunas
                              .Select(line => line.Split(',')) // Divide cada linha em colunas separadas por vírgula
                              .Select(columns => new Recipe // Cria um objeto da classe Recipe com os valores das colunas
                              {
                                  Name = columns[0],
                                  Ingredients = columns[1],
                                  Instructions = columns[2]
                              })
                              .ToArray(); // Converte em um array

            // Chama a função GenerateRecipe com os dados das receitas
            var generatedRecipe = generator.GenerateRecipe(recipes);

            // Verifica se a receita gerada não é nula
            Assert.IsNotNull(generatedRecipe);

            // Verifica se a receita gerada tem um nome não vazio
            Assert.IsNotEmpty(generatedRecipe.Name);

            // Verifica se a receita gerada tem ingredientes não vazios
            Assert.IsNotEmpty(generatedRecipe.Ingredients);

            // Verifica se a receita gerada tem instruções não vazias
            Assert.IsNotEmpty(generatedRecipe.Instructions);
        }
    }
}
