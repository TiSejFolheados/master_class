import 'package:flutter_test/flutter_test.dart';
import 'package:master_class/modulo_0/imc/imc.dart';

void main() {
  test("IMC - Magreza", () {
    const double altura = 1.83;
    const double peso = 50;
    final Imc imc = Imc(altura: altura, peso: peso);
    double calc = imc.calc();
    String analise = imc.analise(calc);
    imc.printImc(calc);

    expect(analise, "Magreza");
  });

  test("IMC - Normal", () {
    const double altura = 1.83;
    const double peso = 83;
    final Imc imc = Imc(altura: altura, peso: peso);

    double calc = imc.calc();
    String analise = imc.analise(calc);
    imc.printImc(calc);

    expect(analise, "Normal");
  });

  test("IMC - Sobrepeso", () {
    const double altura = 1.83;
    const double peso = 100;
    final Imc imc = Imc(altura: altura, peso: peso);

    double calc = imc.calc();
    String analise = imc.analise(calc);
    imc.printImc(calc);

    expect(analise, "Sobrepeso");
  });

  test("IMC - Obesidade", () {
    const double altura = 1.83;
    const double peso = 120;
    final Imc imc = Imc(altura: altura, peso: peso);

    double calc = imc.calc();
    String analise = imc.analise(calc);
    imc.printImc(calc);

    expect(analise, "Obesidade");
  });

  test("IMC - Obesidade Grave", () {
    const double altura = 1.83;
    const double peso = 200;
    final Imc imc = Imc(altura: altura, peso: peso);

    double calc = imc.calc();
    String analise = imc.analise(calc);
    imc.printImc(calc);

    expect(analise, "Obesidade Grave");
  });


}
