import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class/modulo_0/imc/imc.dart';
import 'package:master_class/modulo_0/imc/imc_bloc_event.dart';
import 'package:master_class/modulo_0/imc/imc_bloc_state.dart';

class ImcBloc extends Bloc<ImcEvent, ImcState> {
  ImcBloc() : super(ImcStateInit.init()) {
    on<ImcPesoChanged>(_pesoChanged);
    on<ImcAlturaChanged>(_alturaChanged);
    on<ImcReset>(_reset);
    on<ImcCalc>(_calc);
  }

  void _pesoChanged(ImcPesoChanged event, Emitter<ImcState> emitter) {
    emitter(ImcStateInit.field(state: state, peso: () => event.peso));
  }

  void _alturaChanged(ImcAlturaChanged event, Emitter<ImcState> emitter) {
    emitter(ImcStateInit.field(state: state, altura: () => event.altura));
  }

  void _reset(ImcReset event, Emitter<ImcState> emitter) {
    emitter(ImcStateInit.init());
  }

  void _calc(ImcCalc event, Emitter<ImcState> emitter) async {
    if (state.isValidPeso && state.isValidAltura) {
      emitter(ImcStateLoading(state));

      await Future.delayed(const Duration(seconds: 1));

      final imc = Imc(peso: state.peso!, altura: state.altura!);
      final double calc = imc.calc();
      emitter(ImcStateResult(state, calc, imc.printImc(calc)));
    }
  }
}
