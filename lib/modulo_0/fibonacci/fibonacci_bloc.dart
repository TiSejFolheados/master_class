import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class/modulo_0/fibonacci/fibonacci.dart';
import 'package:master_class/modulo_0/fibonacci/fibonacci_bloc_event.dart';
import 'package:master_class/modulo_0/fibonacci/fibonacci_bloc_state.dart';

class FibonacciBloc extends Bloc<FibonacciEvent, FibonacciState> {
  FibonacciBloc() : super(FibonacciStateInit.init()) {
    on<FibonacciTermoChanged>(_termosChanged);
    on<FibonacciReset>(_reset);
    on<FibonacciGenerate>(_generate);
  }

  void _termosChanged(FibonacciTermoChanged event, Emitter<FibonacciState> emitter) {
    emitter(FibonacciStateInit(event.termos));
  }

  void _reset(FibonacciReset event, Emitter<FibonacciState> emitter) {
    emitter(FibonacciStateInit.init());
  }

  void _generate(FibonacciGenerate event, Emitter<FibonacciState> emitter) async {
    if (state.isValidTermosSize) {
      emitter(FibonacciStateLoading(state));

      await Future.delayed(const Duration(seconds: 1));

      final sequencia = Fibonacci.sequence(state.termos!);
      emitter(FibonacciStateResult(state, sequencia));
    } else {
      emitter(FibonacciStateValidationError(state));
    }
  }
}
