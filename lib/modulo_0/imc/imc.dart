/* 
* IMC é a sigla para 
*  Índice de Massa Corpórea, 
*  parâmetro adotado pela Organização Mundial de Saúde para calcular o peso 
*  ideal de cada pessoa.
*
* O índice é calculado da seguinte maneira: 
*  divide-se o peso do paciente pela sua altura elevada ao quadrado. 
*  Diz-se que o indivíduo tem peso normal quando o resultado do IMC está entre 
*  18,5 e 24,9.
*/

class Imc {
  final double peso;
  final double altura;

  Imc({required this.peso, required this.altura});

  double calc() {
    double calc = peso / (altura * altura);
    return double.parse(calc.toStringAsFixed(1));
  }

  String analise(double imc) {
    if (imc < 18.5) {
      return "Magreza";
    }

    if (imc <= 24.9) {
      return "Normal";
    }

    if (imc <= 29.9) {
      return "Sobrepeso";
    }

    if (imc <= 39.9) {
      return "Obesidade";
    }

    return "Obesidade Grave";
  }

  static String printReferencia() {
    String result = "";
    result += "Magreza < 18.5\n";
    result += "Normal 18.5 - 24.9\n";
    result += "Sobrepeso 25.0 - 29.9\n";
    result += "Obesidade 30.0 - 39.9\n";
    result += "Obesidade Grave >= 40.0";

    return result;
  }

  String printImc(double calc) {
    String result = "";
    result += "Altura: $altura (metros)\n";
    result += "Peso: $peso (kilos)\n";
    result += "IMC: ${calc.toStringAsFixed(1)}\n";
    result += "Análise: ${analise(calc)}\n";
    result += "\n";
    result += "Valores de Referência\n";
    result += Imc.printReferencia();

    return result;
  }
}
