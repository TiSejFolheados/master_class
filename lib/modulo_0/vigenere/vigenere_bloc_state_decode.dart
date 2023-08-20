sealed class VigenereStateDecode {
  final String text;
  final String key;

  VigenereStateDecode({required this.text, required this.key});

  VigenereStateDecode.state(VigenereStateDecode state) : this(text: state.text, key: state.key);

  bool get isValidText => text.isNotEmpty;

  bool get isValidKey => key.isNotEmpty;

  bool get isValidKeySize => isValidKey && isValidText && text.length == key.length;
}

class VigenereStateDecodeInit extends VigenereStateDecode {
  VigenereStateDecodeInit({required super.text, required super.key});

  VigenereStateDecodeInit.init() : super(key: "", text: "");

  VigenereStateDecodeInit.field({
    required VigenereStateDecode state,
    String? text,
    String? key,
  }) : this(
          text: text ?? state.text,
          key: key ?? state.key,
        );
}

class VigenereStateDecodeLoading extends VigenereStateDecode {
  VigenereStateDecodeLoading(VigenereStateDecode state) : super.state(state);
}

class VigenereStateDecodeDecoded extends VigenereStateDecode {
  final String textDecode;

  VigenereStateDecodeDecoded(VigenereStateDecode state, this.textDecode) : super.state(state);
}

class VigenereStateDecodeError extends VigenereStateDecode {
  final String error;

  VigenereStateDecodeError(VigenereStateDecode state, String error)
      : error = error.replaceAll("Exception: ", ""),
        super.state(state);
}
