import 'package:flutter_test/flutter_test.dart';
import 'package:master_class/modulo_0/regra3/regra3.dart';

void main() {
  test("Calcula valor de A", () {
    final regra3 = Regra3(
      valueA: null,
      valueA1: 100,
      valueB: 0.5,
      valueB1: 50,
    );
    final fieldNull = regra3.fieldNull();
    final result = regra3.calc(fieldNull);

    expect(result, equals(1));
  });

  test("Calcula valor de A1", () {
    final regra3 = Regra3(
      valueA1: null,
      valueA: 1,
      valueB: 0.5,
      valueB1: 50,
    );

    final fieldNull = regra3.fieldNull();
    final result = regra3.calc(fieldNull);

    expect(result, equals(100));
  });

  test("Calcula valor de B", () {
    final regra3 = Regra3(
      valueB: null,
      valueA: 1,
      valueA1: 100,
      valueB1: 50,
    );

    final fieldNull = regra3.fieldNull();
    final result = regra3.calc(fieldNull);

    expect(result, equals(0.5));
  });

  test("Calcula valor de B1", () {
    final regra3 = Regra3(
      valueB1: null,
      valueA: 1,
      valueA1: 100,
      valueB: 0.5,
    );

    final fieldNull = regra3.fieldNull();
    final result = regra3.calc(fieldNull);

    expect(result, equals(50));
  });

  group("Exceções", () {
    test("Todos parâmetros enviados", () {
      final regra3 = Regra3(valueA: 1, valueA1: 100, valueB: 50, valueB1: .5);
      expect(() => regra3.fieldNull(), throwsA(isA<Exception>()));
    });

    test("A-A1 nulo", () {
      final regra3 = Regra3(valueA: null, valueA1: null, valueB: 50, valueB1: 0.5);
      expect(() => regra3.fieldNull(), throwsA(isA<Exception>()));
    });

    test("A-B nulo", () {
      final regra3 = Regra3(valueA: null, valueA1: 1, valueB: null, valueB1: 0.5);
      expect(() => regra3.fieldNull(), throwsA(isA<Exception>()));
    });

    test("A1-B1 nulo", () {
      final regra3 = Regra3(valueA: 1, valueA1: null, valueB: 0.5, valueB1: null);
      expect(() => regra3.fieldNull(), throwsA(isA<Exception>()));
    });
  });
}
