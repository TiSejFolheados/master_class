import 'package:flutter_test/flutter_test.dart';
import 'package:master_class/modulo_0/regra3/regra3.dart';

void main() {
  test("Regra de 3 - valor de A", () {
    final Regra3 regra3 = Regra3(
      valueA: null,
      valueA1: 100,
      valueB: 0.5,
      valueB1: 50,
    );
    final String fieldNull = regra3.fieldNull();
    final double result = regra3.calc(fieldNull);
    print(result);

    expect(result, 1);
  });

  test("Regra de 3 - valor de A1", () {
    final Regra3 regra3 = Regra3(
      valueA1: null,
      valueA: 1,
      valueB: 0.5,
      valueB1: 50,
    );

    final String fieldNull = regra3.fieldNull();
    final double result = regra3.calc(fieldNull);
    print(result);

    expect(result, 100);
  });

  test("Regra de 3 - valor de B", () {
    final Regra3 regra3 = Regra3(
      valueB: null,
      valueA: 1,
      valueA1: 100,
      valueB1: 50,
    );

    final String fieldNull = regra3.fieldNull();
    final double result = regra3.calc(fieldNull);
    print(result);

    expect(result, 0.5);
  });

  test("Regra de 3 - valor de B1", () {
    final Regra3 regra3 = Regra3(
      valueB1: null,
      valueA: 1,
      valueA1: 100,
      valueB: 0.5,
    );

    final String fieldNull = regra3.fieldNull();
    final double result = regra3.calc(fieldNull);
    print(result);

    expect(result, 50);
  });

  test("Regra de 3 - todos parâmetros enviados", () {
    final Regra3 regra3 = Regra3(valueA: 1, valueA1: 100, valueB: 50, valueB1: .5);
    expect(() => regra3.fieldNull(), throwsException);
  });

  test("Regra de 3 - A-A1 nulo", () {
    final Regra3 regra3 = Regra3(valueA: null, valueA1: null, valueB: 50, valueB1: 0.5);
    expect(() => regra3.fieldNull(), throwsException);
  });

  test("Regra de 3 - A-B nulo", () {
    final Regra3 regra3 = Regra3(valueA: null, valueA1: 1, valueB: null, valueB1: 0.5);
    expect(() => regra3.fieldNull(), throwsException);
  });

  test("Regra de 3 - A1-B1 nulo", () {
    final Regra3 regra3 = Regra3(valueA: 1, valueA1: null, valueB: 0.5, valueB1: null);
    expect(() => regra3.fieldNull(), throwsException);
  });
}
