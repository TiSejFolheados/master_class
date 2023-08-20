class Mod10 {
  final String number;

  Mod10(this.number);

  bool valida() {
    String cardNumber = number.replaceAll(RegExp(r"\D"), "");

    if (cardNumber.isEmpty) throw Exception("Nenhum número informado");

    List<int> numbers = cardNumber.split("").map((String element) => int.parse(element)).toList();

    if (_digit(numbers) != numbers[numbers.length - 1]) {
      return false;
    }
    return true;
  }

  int _digit(List<int> numbers) {
    int total = 0;
    for (int i = numbers.length - 2; i >= 0; i--) {
      int parcial = numbers[i] * (i.isEven ? 2 : 1);
      total += parcial > 9 ? parcial ~/ 10 + parcial % 10 : parcial;
    }

    int resto = total % 10;
    int digit;
    if (resto <= 0) {
      digit = 0;
    } else {
      digit = 10 - resto;
    }
    return digit;
  }
}
