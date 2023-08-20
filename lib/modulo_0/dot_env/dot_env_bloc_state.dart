sealed class DotEnvState {
  final path = "assets/parameter.env";
  final String property;

  DotEnvState(this.property);

  DotEnvState.state(DotEnvState state) : this(state.property);

  bool get isValidProperty => property.isNotEmpty;
}

class DotEnvStateInit extends DotEnvState {
  DotEnvStateInit(super.property);

  DotEnvStateInit.init() : super("");
}

class DotEnvStateLoading extends DotEnvState {
  DotEnvStateLoading(DotEnvState state) : super.state(state);
}

class DotEnvStateReadProperty extends DotEnvState {
  final dynamic readProperty;

  String get getType => readProperty.runtimeType.toString();

  String get result => "$getType: $readProperty";

  DotEnvStateReadProperty(DotEnvState state, this.readProperty) : super.state(state);
}

class DotEnvStateReadAll extends DotEnvState {
  final dynamic readAll;

  DotEnvStateReadAll(DotEnvState state, this.readAll) : super.state(state);
}

class DotEnvStateError extends DotEnvState {
  final String error;

  DotEnvStateError(DotEnvState state, String error)
      : error = error.replaceAll("Exception: ", ""),
        super.state(state);
}
