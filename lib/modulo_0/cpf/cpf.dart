class Cpf {
  final String cpf;

  Cpf(this.cpf);

  bool valida() {
    String cpfNumber = cpf.replaceAll(RegExp(r"\D"), "");

    if (cpfNumber.isEmpty) throw Exception("Nenhum número informado");
    if (cpfNumber.length != 11) throw Exception("Número inválido!");

    List<int> numbers = cpfNumber
        .split("")
        .map((String element) => int.parse(element))
        .toList();

    if (_digit(numbers) != numbers[9]) {
      return false;
    }
    if (_digit(numbers, indexDigit: 10) != numbers[10]) {
      return false;
    }

    return true;
  }

  int _digit(List<int> numbers, {int indexDigit = 9}) {
    int total = 0;
    int factor = 2;
    for (int i = indexDigit - 1; i >= 0; i--) {
      total += numbers[i] * factor;
      factor++;
    }
    int resto = total % 11;
    int digit;
    if (resto < 2) {
      digit = 0;
    } else {
      digit = 11 - resto;
    }
    return digit;
  }
}
