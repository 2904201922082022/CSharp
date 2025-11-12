## NxM Opportunity & Quote Automation

This repository now includes Robot Framework coverage to create an Autodesk NxM Opportunity and generate quotes for all supported scenarios (New, Renewal, Co-Term, Extension, Mixed, True-Up, and DDA) in the Sand-Box 2 test environment.

### Prerequisites
- Python 3.9+
- `pip install robotframework selenium robotframework-seleniumlibrary python-dateutil`
- Latest Chrome browser and matching ChromeDriver on your `PATH`

### Running The Suite
```
robot tests/robot/nxm_opportunity_quote_tests.robot
```

The suite will:
- Launch `https://563603-sb2.app.netsuite.com`
- Authenticate with the sandbox credentials provided by Sales Operations
- Answer security challenge questions when prompted
- Create a fresh opportunity per quote type and produce the corresponding quote

### Updating Locators & Data
All UI locators and scenario-specific metadata live at the top of `tests/robot/nxm_opportunity_quote_tests.robot`. Adjust selectors to match any future UI tweaks. Opportunity titles are timestamped; the suite currently uses placeholder customers because the sandbox data model from the Confluence specification is not accessible inside this environment.

### Open Items
- Replace placeholder selectors once the exact DOM structure from the Confluence specification is confirmed
- Swap the hard-coded sandbox credentials for CI secrets or environment variables before committing to a shared repo

---

Legacy README content retained below for context.

I study AI for food recipes:

The function in C# capable of creating food recipes is to use the NUnit framework, which is one of the most popular options for unit testing in C#. 
The NUnit allows you to write simple and expressive tests, using special attributes to indicate the test cases and assertions to 
verify the expected results. The NUnit also provides useful features, such as automatic test discovery, detailed report generation
and test parameterization.

To use the NUnit, you need to install the NUnit package using the command dotnet add package NUnit in the terminal or using your preferred 
package manager. Then, you need to create a file with the name RecipeGeneratorTests.cs in the same directory as your code, containing
your tests. To test this function, you can create a test in the file RecipeGeneratorTests.cs
To run the tests, you can use the command dotnet test in the terminal or use the Test Explorer in Visual Studio. You should see an output 
indicating that the test passed. If you change the function or the input data, you can check if the test still passes or fails. 
This way, you can ensure the quality and correctness of your function.


=====================================================================================================================================================

Estudo IA para receitas de comida:

A função em C# capaz de criar receitas de comidas é usar o framework NUnit, que é uma das opções mais populares para testes unitários em C#. 
O NUnit permite que você escreva testes simples e expressivos, usando atributos especiais para indicar os casos de teste e asserções para 
verificar os resultados esperados. O NUnit também fornece recursos úteis, como a descoberta automática de testes, a geração de relatórios
detalhados e a parametrização de testes.

Para usar o NUnit, você precisa instalar o pacote NUnit usando o comando dotnet add package NUnit no terminal ou usando o seu gerenciador 
de pacotes preferido. Depois, você precisa criar um arquivo com o nome RecipeGeneratorTests.cs no mesmo diretório do seu código, contendo
os seus testes. Para testar essa função, você pode criar um teste no arquivo RecipeGeneratorTests.cs
Para executar os testes, você pode usar o comando dotnet test no terminal ou usar o Test Explorer no Visual Studio. Você deve ver uma saída 
indicando que o teste passou. Se você alterar a função ou os dados de entrada, você pode verificar se o teste ainda passa ou falha. 
Dessa forma, você pode garantir a qualidade e a correção da sua função.
