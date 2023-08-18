class Fibonacci {
  static List<int> sequence(int termos) {
    List<int> fibonacci = <int>[];

    if (termos > 0) {
      fibonacci.add(0);
    }

    if (termos > 1) {
      fibonacci.add(1);
    }

    if (termos > 2) {
      for (int i = 2; i < termos; i++) {
        fibonacci.add(fibonacci[i - 2] + fibonacci[i - 1]);
      }
    }

    return fibonacci;
  }
}
