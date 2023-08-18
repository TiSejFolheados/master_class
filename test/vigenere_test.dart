import 'package:flutter_test/flutter_test.dart';
import 'package:master_class/modulo_0/vigenere/vigenere.dart';

void main() {
  test("Vigenere Encode", () {
    const String text = "Fernando Augusto Soares de Rezende *25/02/1983";
    print("Text: $text");

    final Vigenere vigenereEncode = Vigenere(text);
    final String encode = vigenereEncode.encode();
    final String key = vigenereEncode.key!;

    print("Encode: $encode");
    print("Key: $key");

    final Vigenere vigenereDecode = Vigenere(encode, key: key);
    String decode = vigenereDecode.decode();
    print("Decode: $decode");

    expect(decode, text.toUpperCase());
  });

  test("Vigenere - key null", () {
    print("");
    print("Não informada chave Key");

    expect(()=>Vigenere("FERNANDO").decode(), throwsException);
  });
}
