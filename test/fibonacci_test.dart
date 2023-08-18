import 'package:flutter_test/flutter_test.dart';
import 'package:master_class/modulo_0/fibonacci/fibonacci.dart';

void main() {
  test("Fibonacci", () {
    final List<int> fibonacci = Fibonacci.sequence(20);

    for (int x in fibonacci) {
      print(x);
    }

    expect(fibonacci[19], 4181);
  });
}
