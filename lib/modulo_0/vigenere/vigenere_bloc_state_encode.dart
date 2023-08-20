sealed class VigenereStateEncode {
  final String text;
  final String key;

  VigenereStateEncode({required this.text, required this.key});

  VigenereStateEncode.state(VigenereStateEncode state) : this(text: state.text, key: state.key);

  bool get isValidText => text.isNotEmpty;

  bool get isValidKey => key.isNotEmpty;

  bool get isValidKeySize => isValidKey && isValidText && text.length == key.length;
}

class VigenereStateEncodeInit extends VigenereStateEncode {
  VigenereStateEncodeInit({required super.text, required super.key});

  VigenereStateEncodeInit.init() : super(key: "", text: "");

  VigenereStateEncodeInit.field({
    required VigenereStateEncode state,
    String? text,
    String? key,
  }) : this(
          text: text ?? state.text,
          key: key ?? state.key,
        );
}

class VigenereStateEncodeLoading extends VigenereStateEncode {
  VigenereStateEncodeLoading(VigenereStateEncode state) : super.state(state);
}

class VigenereStateEncodeEncoded extends VigenereStateEncode {
  final String textEncode;

  VigenereStateEncodeEncoded({
    required VigenereStateEncode state,
    required this.textEncode,
    required String key,
  }) : super(text: state.text, key: key);
}

class VigenereStateEncodeError extends VigenereStateEncode {
  final String error;

  VigenereStateEncodeError(VigenereStateEncode state, String error)
      : error = error.replaceAll("Exception: ", ""),
        super.state(state);
}
