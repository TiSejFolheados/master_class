import 'package:flutter_test/flutter_test.dart';
import 'package:master_class/modulo_0/cpf/cpf.dart';

void main() {
  test("CPF", () {
    final Cpf cpf = Cpf("22335401823");

    expect(cpf.valida(), true);
  });
}
