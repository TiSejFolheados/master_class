import 'dart:math';

class Vigenere {
  final String chars = "ABCDEFGHIJKLMNOPQRSTUVXWYZ";

  String text;
  String? key;

  Vigenere(this.text, {this.key}) {
    text = text.toUpperCase();
  }

  void geraKey() {
    Random random = Random();
    key = String.fromCharCodes(Iterable.generate(text.length, (int index) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  String encode() {
    if (key == null) {
      geraKey();
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

  String decode(){
    if( key == null){
      throw Exception("Não informada a chave Key!");
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
