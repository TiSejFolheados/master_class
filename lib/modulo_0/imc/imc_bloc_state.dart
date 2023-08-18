enum ImcStateField {
  fieldPeso,
  fieldAltura,
}

abstract class ImcState {
  final double? peso;
  final double? altura;

  ImcState({
    this.peso,
    this.altura,
  });

  ImcState.state(ImcState state)
      : this(
          peso: state.peso,
          altura: state.altura,
        );

  ImcState.field({
    required ImcState state,
    required ImcStateField field,
    required double? value,
  }) : this(
          peso: field == ImcStateField.fieldPeso ? value : state.peso,
          altura: field == ImcStateField.fieldAltura ? value : state.altura,
        );

  bool get isValidPeso => peso != null;

  bool get isValidAltura => altura != null;
}

class ImcStateInit extends ImcState {
  ImcStateInit({super.peso, super.altura});

  ImcStateInit.init();

  ImcStateInit.field({
    required ImcState state,
    required ImcStateField field,
    required double? value,
  }) : super.field(
          state: state,
          field: field,
          value: value,
        );
}

class ImcStateLoading extends ImcState {
  ImcStateLoading(ImcState state) : super.state(state);
}

class ImcStateResult extends ImcState {
  final double imc;
  final String analise;

  ImcStateResult(ImcState state, this.imc, this.analise) : super.state(state);
}
