import 'package:flutter_test/flutter_test.dart';
import 'package:master_class/modulo_0/imc/imc.dart';

void main() {
  test("Magreza", () {
    const altura = 1.83;
    const peso = 50.0;

    final imc = Imc(altura: altura, peso: peso);
    final calc = imc.calc();
    final analise = imc.analise(calc);

    imc.printImc(calc);

    expect(calc, equals(14.9));
    expect(analise, equals("Magreza"));
  });

  test("Normal", () {
    const altura = 1.83;
    const peso = 83.0;
    final imc = Imc(altura: altura, peso: peso);

    final calc = imc.calc();
    final analise = imc.analise(calc);

    imc.printImc(calc);

    expect(calc, equals(24.8));
    expect(analise, equals("Normal"));
  });

  test("Sobrepeso", () {
    const altura = 1.83;
    const peso = 100.0;
    final imc = Imc(altura: altura, peso: peso);

    final calc = imc.calc();
    final analise = imc.analise(calc);

    imc.printImc(calc);

    expect(calc, equals(29.9));
    expect(analise, equals("Sobrepeso"));
  });

  test("Obesidade", () {
    const altura = 1.83;
    const peso = 120.0;
    final imc = Imc(altura: altura, peso: peso);

    final calc = imc.calc();
    final analise = imc.analise(calc);

    imc.printImc(calc);

    expect(calc, equals(35.8));
    expect(analise, equals("Obesidade"));
  });

  test("Obesidade Grave", () {
    const altura = 1.83;
    const peso = 200.0;
    final imc = Imc(altura: altura, peso: peso);

    final calc = imc.calc();
    final analise = imc.analise(calc);

    imc.printImc(calc);

    expect(calc, equals(59.7));
    expect(analise, equals("Obesidade Grave"));
  });

  group("Exceção", ()
  {
    test("Altura 0", () {
      const altura = 0.0;
      const peso = 85.0;

      expect(() => Imc(altura: altura, peso: peso), throwsA(isA<Exception>()));
    });

    test("Peso 0", () {
      const altura = 1.83;
      const peso = 0.0;

      expect(() => Imc(altura: altura, peso: peso), throwsA(isA<Exception>()));
    });
  });
}
