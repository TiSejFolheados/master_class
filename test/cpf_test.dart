import 'package:flutter_test/flutter_test.dart';
import 'package:master_class/modulo_0/cpf/cpf.dart';

void main() {
  test("CPF Válido", () {
    final valido = Cpf("834.406.940-89").valida();

    expect(valido, equals(true));
  });

  test("CPF Inválido", () {
    final valido = Cpf("834.406.940-88").valida();

    expect(valido, equals(false));
  });
}
