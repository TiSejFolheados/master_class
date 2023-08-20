sealed class VigenereEvent {}

class VigenereKeyEncodeChanged extends VigenereEvent {
  final String key;

  VigenereKeyEncodeChanged(this.key);
}

class VigenereTextEncodeChanged extends VigenereEvent {
  final String text;

  VigenereTextEncodeChanged(this.text);
}

class VigenereKeyDecodeChanged extends VigenereEvent {
  final String key;

  VigenereKeyDecodeChanged(this.key);
}

class VigenereTextDecodeChanged extends VigenereEvent {
  final String text;

  VigenereTextDecodeChanged(this.text);
}

class VigenereResetEncode extends VigenereEvent {}

class VigenereResetDecode extends VigenereEvent {}

class VigenereEncode extends VigenereEvent {}

class VigenereDecode extends VigenereEvent {}
