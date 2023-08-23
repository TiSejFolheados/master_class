import 'package:flutter_test/flutter_test.dart';
import 'package:master_class/modulo_0/mod10/mod10.dart';

void main() {
  test("Cartão Válido", () {
    final mod10 = Mod10("4916 6418 5936 9080");

    expect(mod10.valida(), equals(true));
  });

  test("Cartão Inválido", () {
    final mod10 = Mod10("5419 8250 0346 1210");

    expect(mod10.valida(), equals(false));
  });
}
