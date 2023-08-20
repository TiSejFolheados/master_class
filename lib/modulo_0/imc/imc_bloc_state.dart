sealed class ImcState {
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

  bool get isValidPeso => peso != null;

  bool get isValidAltura => altura != null;
}

class ImcStateInit extends ImcState {
  ImcStateInit({super.peso, super.altura});

  ImcStateInit.init();

  ImcStateInit.field({
    required ImcState state,
    double? Function()? peso,
    double? Function()? altura,
  }) : this(
          peso: peso != null ? peso() : state.peso,
          altura: altura != null ? altura() : state.altura,
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
