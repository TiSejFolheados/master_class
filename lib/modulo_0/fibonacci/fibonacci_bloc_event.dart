sealed class FibonacciEvent {}

class FibonacciTermoChanged extends FibonacciEvent {
  final int? termos;

  FibonacciTermoChanged(String value) : termos = value.isEmpty ? null : int.parse(value);
}

class FibonacciReset extends FibonacciEvent {}

class FibonacciGenerate extends FibonacciEvent {}
