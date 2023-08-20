import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class/modulo_0/lcov/lcov.dart';
import 'package:master_class/modulo_0/lcov/lcov_bloc_event.dart';
import 'package:master_class/modulo_0/lcov/lcov_bloc_state.dart';

class LcovBloc extends Bloc<LcovEvent, LcovState> {
  LcovBloc() : super(LcovStateInit()) {
    on<LcovLoad>(_load);
  }
}


void _load(LcovLoad event, Emitter<LcovState> emitter) async {
  try {
    emitter(LcovStateLoading());

    await Future.delayed(const Duration(seconds: 1));

    final lcov = Lcov.init();

    emitter(LcovStateLoaded(lcov));
  } catch (e) {
    emitter(LcovStateError(e.toString()));
  }
}
