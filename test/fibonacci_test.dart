import 'package:flutter_test/flutter_test.dart';
import 'package:master_class/modulo_0/fibonacci/fibonacci.dart';

void main() {
  test("Termo 19", () {
    final fibonacci = Fibonacci.sequence(20);

    expect(fibonacci[19], equals(4181));
  });
}
