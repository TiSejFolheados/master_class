import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class/modulo_0/cpf/cpf.dart';
import 'package:master_class/modulo_0/cpf/cpf_bloc_event.dart';
import 'package:master_class/modulo_0/cpf/cpf_bloc_state.dart';

class CpfBloc extends Bloc<CpfEvent, CpfState> {
  CpfBloc() : super(CpfStateInit.init()) {
    on<CpfNumberChanged>(_numberChanged);
    on<CpfReset>(_reset);
    on<CpfValidate>(_valida);
  }

  void _numberChanged(CpfNumberChanged event, Emitter<CpfState> emitter) {
    emitter(CpfStateInit(event.number));
  }

  void _reset(CpfReset event, Emitter<CpfState> emitter) {
    emitter(CpfStateInit.init());
  }

  void _valida(CpfValidate event, Emitter<CpfState> emitter) async {
    try {
      if (state.isValidNumberSize) {
        emitter(CpfStateLoading(state));

        await Future.delayed(const Duration(seconds: 1));

        final Cpf cpf = Cpf(state.number);
        if (cpf.valida()) {
          emitter(CpfStateCpfValid(state));
        } else {
          emitter(CpfStateCpfInvalid(state));
        }
      } else {
        emitter(CpfStateValidationError(state));
      }
    } catch (e) {
      emitter(CpfStateError(state, e.toString()));
    }
  }
}
