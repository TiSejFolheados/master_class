import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class/modulo_0/dot_env/dot_env.dart';
import 'package:master_class/modulo_0/dot_env/dot_env_bloc_event.dart';
import 'package:master_class/modulo_0/dot_env/dot_env_bloc_state.dart';

class DotEnvBloc extends Bloc<DotEnvEvent, DotEnvState> {
  DotEnvBloc() : super(DotEnvStateInit.init()) {
    on<DotEnvPropertyChanged>(_propertyChanged);
    on<DotEnvRead>(_read);
    on<DotEnvReset>(_reset);
  }

  void _propertyChanged(DotEnvPropertyChanged event, Emitter<DotEnvState> emitter) {
    emitter(DotEnvStateInit(event.property));
  }

  void _reset(DotEnvReset event, Emitter<DotEnvState> emitter) {
    emitter(DotEnvStateInit.init());
  }

  void _read(DotEnvRead event, Emitter<DotEnvState> emitter) async {
    try {
      emitter(DotEnvStateLoading(state));

      await Future.delayed(const Duration(seconds: 1));

      final dotEnv = DotEnv(state.path);
      if (state.isValidProperty) {
        final readProperty = await dotEnv.read(property: state.property);
        emitter(DotEnvStateReadProperty(state, readProperty));
      } else {
        final readAll = await dotEnv.read();
        emitter(DotEnvStateReadAll(state, readAll));
      }
    } catch (e) {
      emitter(DotEnvStateError(state, e.toString()));
    }
  }
}
