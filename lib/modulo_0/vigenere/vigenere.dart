import 'dart:math';

class Vigenere {
  final String chars = "ABCDEFGHIJKLMNOPQRSTUVXWYZ";

  final String text;
  late String? key;

  Vigenere({required String text, this.key}) : text = text.toUpperCase();

  void geraKey() {
    Random random = Random();
    key = String.fromCharCodes(Iterable.generate(text.length, (int index) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  String encode() {
    if (key == null) {
      geraKey();
    }

    if (key!.length != text.length) {
      throw Exception("A key deve ter o mesmo tamanho do texto");
    }

    List<int> charsText = text.codeUnits;
    List<int> charsKey = key!.codeUnits;

    return String.fromCharCodes(Iterable.generate(text.length, (int index) {
      if (chars.codeUnits.contains(charsText[index])) {
        return "A".codeUnitAt(0) + (charsText[index] + charsKey[index]) % 26;
      } else {
        return charsText[index];
      }
    }));
  }

  String decode() {
    if (key == null) {
      throw Exception("Não informada a chave Key!");
    }
    if (key!.length != text.length) {
      throw Exception("A key deve ter o mesmo tamanho do texto");
    }
    List<int> charsText = text.codeUnits;
    List<int> charsKey = key!.codeUnits;

    return String.fromCharCodes(Iterable.generate(text.length, (int index) {
      if (chars.codeUnits.contains(charsText[index])) {
        return "A".codeUnitAt(0) + (charsText[index] - charsKey[index] + 26) % 26;
      } else {
        return charsText[index];
      }
    }));
  }
}
