sealed class CpfState {
  final String number;

  CpfState(this.number);

  CpfState.state(CpfState state) : this(state.number);

  bool get isValidNumber => number.isNotEmpty;

  bool get isValidNumberSize => number.length == 14;
}

class CpfStateInit extends CpfState {
  CpfStateInit(super.number);

  CpfStateInit.init() : super("");
}

class CpfStateValidationError extends CpfState {
  CpfStateValidationError(CpfState state) : super.state(state);
}

class CpfStateLoading extends CpfState {
  CpfStateLoading(CpfState state) : super.state(state);
}

class CpfStateCpfValid extends CpfState {
  CpfStateCpfValid(CpfState state) : super.state(state);
}

class CpfStateCpfInvalid extends CpfState {
  CpfStateCpfInvalid(CpfState state) : super.state(state);
}

class CpfStateError extends CpfState {
  final String error;

  CpfStateError(CpfState state, String error)
      : error = error.replaceAll("Exception: ", ""),
        super.state(state);
}
