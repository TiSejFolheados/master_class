import 'package:flutter_test/flutter_test.dart';
import 'package:master_class/modulo_0/lcov/lcov.dart';

void main() {
  test("Carregamento da Lista FileReports", () {
    final lcov = Lcov.init();

    expect(lcov.fileReports, isNotEmpty);
  });

  test("Cálculo coverage", () {
    final coverage = Lcov.init().coverage();

    expect(coverage, isNotNull);
  });
}
