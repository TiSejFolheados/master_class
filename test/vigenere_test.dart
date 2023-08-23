import 'package:flutter_test/flutter_test.dart';
import 'package:master_class/modulo_0/vigenere/vigenere.dart';

void main() {
  test("Encode/Decode", () {
    const text = "Fernando Augusto Soares de Rezende *25/02/1983";

    final vigenereEncode = Vigenere(text: text);
    final encode = vigenereEncode.encode();
    final key = vigenereEncode.key!;

    final vigenereDecode = Vigenere(text: encode, key: key);
    final decode = vigenereDecode.decode();

    expect(decode, equals(text.toUpperCase()));
  });

  group("Exceção", () {
    test("Encode key tamanho diferente do texto", () {
      expect(() => Vigenere(text: "FERNANDO", key: "ABC").encode(), throwsA(isA<Exception>()));
    });
    test("Decode key tamanho diferente do texto", () {
      expect(() => Vigenere(text: "FERNANDO", key: "ABC").decode(), throwsA(isA<Exception>()));
    });
    test("Decode key null", () {
      expect(() => Vigenere(text: "FERNANDO").decode(), throwsA(isA<Exception>()));
    });
  });
}
