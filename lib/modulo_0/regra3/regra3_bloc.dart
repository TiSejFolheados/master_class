import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class/modulo_0/regra3/regra3.dart';
import 'package:master_class/modulo_0/regra3/regra3_bloc_event.dart';
import 'package:master_class/modulo_0/regra3/regra3_bloc_state.dart';

class Regra3Bloc extends Bloc<Regra3Event, Regra3State> {
  Regra3Bloc() : super(Regra3StateInit.init()) {
    on<Regra3ValueAChanged>(_valueAChanged);
    on<Regra3ValueA1Changed>(_valueA1Changed);
    on<Regra3ValueBChanged>(_valueBChanged);
    on<Regra3ValueB1Changed>(_valueB1Changed);
    on<Regra3Calc>(_calcular);
    on<Regra3Reset>(_reset);
  }

  void _valueAChanged(Regra3ValueAChanged event, Emitter<Regra3State> emitter) {
    emitter(Regra3StateInit.field(
      state: state,
      field: Regra3StateField.fieldValueA,
      value: event.valueA,
    ));
  }

  void _valueA1Changed(Regra3ValueA1Changed event, Emitter<Regra3State> emitter) {
    emitter(Regra3StateInit.field(
      state: state,
      field: Regra3StateField.fieldValueA1,
      value: event.valueA1,
    ));
  }

  void _valueBChanged(Regra3ValueBChanged event, Emitter<Regra3State> emitter) {
    emitter(Regra3StateInit.field(
      state: state,
      field: Regra3StateField.fieldValueB,
      value: event.valueB,
    ));
  }

  void _valueB1Changed(Regra3ValueB1Changed event, Emitter<Regra3State> emitter) {
    emitter(Regra3StateInit.field(
      state: state,
      field: Regra3StateField.fieldValueB1,
      value: event.valueB1,
    ));
  }

  void _reset(Regra3Reset event, Emitter<Regra3State> emitter) {
    emitter(Regra3StateInit.init());
  }

  void _calcular(Regra3Calc event, Emitter<Regra3State> emitter) async {
    try {
      final Regra3 regra3 = Regra3(
        valueA: state.valueA,
        valueA1: state.valueA1,
        valueB: state.valueB,
        valueB1: state.valueB1,
      );

      final String fieldNull = regra3.fieldNull();
      final double calc = regra3.calc(fieldNull);

      Regra3StateInit newState = Regra3StateInit.field(
          state: state,
          field: Regra3StateField.values.firstWhere(
            (Regra3StateField element) => element.name == "fieldValue$fieldNull",
          ),
          value: calc);
      emitter(Regra3StateLoading(newState));

      await Future.delayed(const Duration(seconds: 1));

      emitter(Regra3StateResult(
        state,
        calc,
        fieldNull,
      ));
    } catch (e) {
      emitter(Regra3StateError(
        state,
        e.toString(),
      ));
    }
  }
}
