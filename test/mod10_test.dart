import 'package:flutter_test/flutter_test.dart';
import 'package:master_class/modulo_0/mod10/mod10.dart';

void main() {
  test("MOD10 - Cartão válido", () {
    final Mod10 mod10 = Mod10("4916 6418 5936 9080");

    expect(mod10.valida(), true);
  });

  test("MOD10 - Cartão inválido", () {
    final Mod10 mod10 = Mod10("5419 8250 0346 1210");

    expect(mod10.valida(), false);
  });

}
