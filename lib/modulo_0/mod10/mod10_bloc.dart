import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class/modulo_0/mod10/mod10.dart';
import 'package:master_class/modulo_0/mod10/mod10_bloc_event.dart';
import 'package:master_class/modulo_0/mod10/mod10_bloc_state.dart';

class Mod10Bloc extends Bloc<Mod10Event, Mod10State> {
  Mod10Bloc() : super(Mod10StateInit.init()) {
    on<Mod10NumberChanged>(_numberChanged);
    on<Mod10Reset>(_reset);
    on<Mod10Validate>(_valida);
  }

  void _numberChanged(Mod10NumberChanged event, Emitter<Mod10State> emitter) {
    emitter(Mod10StateInit(event.number));
  }

  void _reset(Mod10Reset event, Emitter<Mod10State> emitter) {
    emitter(Mod10StateInit.init());
  }

  void _valida(Mod10Validate event, Emitter<Mod10State> emitter) async {
    try {
      if (state.isValidNumberSize) {
        emitter(Mod10StateLoading(state));

        await Future.delayed(const Duration(seconds: 1));

        final Mod10 mod10 = Mod10(state.number);
        if (mod10.valida()) {
          emitter(Mod10StateMod10Valid(state));
        } else {
          emitter(Mod10StateMod10Invalid(state));
        }
      } else {
        emitter(Mod10StateValidationError(state));
      }
    } catch (e) {
      emitter(Mod10StateError(state, e.toString()));
    }
  }
}
