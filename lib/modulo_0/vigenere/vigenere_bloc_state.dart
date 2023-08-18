abstract class VigenereState {
  final String text;
  final String key;

  VigenereState({required this.text, required this.key});

  VigenereState.state(VigenereState state) : this(text: state.text, key: state.key);

  bool get isValidText => text.isNotEmpty;

  bool get isValidKey => text.isNotEmpty;
}

class VigenereStateInit extends VigenereState {
  VigenereStateInit({required super.text, required super.key});

  VigenereStateInit.init() : super(key: "", text: "");
}

class VigenereStateLoading extends VigenereState {
  VigenereStateLoading(VigenereState state) : super.state(state);
}

class VigenereStateEncode extends VigenereState {
  final String textEncode;

  VigenereStateEncode(VigenereState state, this.textEncode) : super.state(state);
}
