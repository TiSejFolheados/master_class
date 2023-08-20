sealed class Mod10State {
  final String number;

  Mod10State(this.number);

  Mod10State.state(Mod10State state) : this(state.number);

  bool get isValidNumber => number.isNotEmpty;

  bool get isValidNumberSize => number.length == 19;
}

class Mod10StateInit extends Mod10State {
  Mod10StateInit(super.number);

  Mod10StateInit.init() : super("");
}

class Mod10StateValidationError extends Mod10State {
  Mod10StateValidationError(Mod10State state) : super.state(state);
}

class Mod10StateLoading extends Mod10State {
  Mod10StateLoading(Mod10State state) : super.state(state);
}

class Mod10StateMod10Valid extends Mod10State {
  Mod10StateMod10Valid(Mod10State state) : super.state(state);
}

class Mod10StateMod10Invalid extends Mod10State {
  Mod10StateMod10Invalid(Mod10State state) : super.state(state);
}

class Mod10StateError extends Mod10State {
  final String error;

  Mod10StateError(Mod10State state, String erro)
      : error = erro.replaceAll("Exception: ", ""),
        super.state(state);
}
