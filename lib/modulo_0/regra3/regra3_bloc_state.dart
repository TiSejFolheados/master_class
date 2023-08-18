enum Regra3StateField {
  fieldValueA,
  fieldValueA1,
  fieldValueB,
  fieldValueB1,
}

abstract class Regra3State {
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

  Regra3State.field({
    required Regra3State state,
    required Regra3StateField field,
    required double? value,
  }) : this(
          valueA: field == Regra3StateField.fieldValueA ? value : state.valueA,
          valueA1: field == Regra3StateField.fieldValueA1 ? value : state.valueA1,
          valueB: field == Regra3StateField.fieldValueB ? value : state.valueB,
          valueB1: field == Regra3StateField.fieldValueB1 ? value : state.valueB1,
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

  Regra3StateInit.field({
    required Regra3State state,
    required Regra3StateField field,
    required double? value,
  }) : super.field(
          state: state,
          field: field,
          value: value,
        );
}

class Regra3StateLoading extends Regra3State {
  Regra3StateLoading(Regra3State state) : super.state(state);
}

class Regra3StateResult extends Regra3State {
  final double valueX;
  final String fieldX;


  Regra3StateResult(Regra3State state, this.valueX, this.fieldX) : super.state(state);

  String get result => "$fieldX - $valueX";
}

class Regra3StateError extends Regra3State {
  final String error;

  Regra3StateError(Regra3State state, String error)
      : error = error.replaceAll("Exception: ", ""),
        super.state(state);
}
