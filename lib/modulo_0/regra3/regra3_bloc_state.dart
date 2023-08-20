sealed class Regra3State {
  final double? valueA;
  final double? valueA1;
  final double? valueB;
  final double? valueB1;

  Regra3State({
    this.valueA,
    this.valueA1,
    this.valueB,
    this.valueB1,
  });

  Regra3State.state(Regra3State state)
      : this(
          valueA: state.valueA,
          valueA1: state.valueA1,
          valueB: state.valueB,
          valueB1: state.valueB1,
        );
}

class Regra3StateInit extends Regra3State {
  Regra3StateInit({
    super.valueA,
    super.valueA1,
    super.valueB,
    super.valueB1,
  });

  Regra3StateInit.init();

  Regra3StateInit.fields({
    required Regra3State state,
    double? Function()? valueA,
    double? Function()? valueA1,
    double? Function()? valueB,
    double? Function()? valueB1,
  }) : this(
          valueA: valueA != null ? valueA() : state.valueA,
          valueA1: valueA1 != null ? valueA1() : state.valueA1,
          valueB: valueB != null ? valueB() : state.valueB,
          valueB1: valueB1 != null ? valueB1() : state.valueB1,
        );
}

class Regra3StateLoading extends Regra3State {
  Regra3StateLoading(Regra3State state) : super.state(state);
}

class Regra3StateResult extends Regra3State {
  final double valueX;
  final String fieldX;

  Regra3StateResult(Regra3State state, this.valueX, this.fieldX)
      : super(
          valueA: state.valueA ?? valueX,
          valueA1: state.valueA1 ?? valueX,
          valueB: state.valueB ?? valueX,
          valueB1: state.valueB1 ?? valueX,
        );

  String get result => "$fieldX - $valueX";
}

class Regra3StateError extends Regra3State {
  final String error;

  Regra3StateError(Regra3State state, String error)
      : error = error.replaceAll("Exception: ", ""),
        super.state(state);
}
