import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class/modulo_0/regra3/regra3_bloc.dart';
import 'package:master_class/modulo_0/regra3/regra3_bloc_event.dart';
import 'package:master_class/modulo_0/regra3/regra3_bloc_state.dart';
import 'package:master_class/util/widget/appbar_default.dart';
import 'package:master_class/util/widget/button_loading.dart';
import 'package:master_class/util/widget/card_result.dart';
import 'package:master_class/util/widget/input_text.dart';

class Regra3Page extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _controllerText = TextEditingController();

  Regra3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Regra3Bloc(),
      child: Scaffold(
        appBar: const AppBarDefault("Regra de 3").build(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const Text("Calcule a Regra de 3", style: TextStyle(fontWeight: FontWeight.bold)),
                const Text("Mantenha um campo Nulo para ser calculado"),
                Card(
                  child: Form(
                    key: _formKey,
                    child: BlocBuilder<Regra3Bloc, Regra3State>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: _valueField(
                                      context: context,
                                      state: state,
                                      field: "A",
                                      label: "A",
                                      hintText: "informe A",
                                      onChanged: (value) => context.read<Regra3Bloc>().add(Regra3ValueAChanged(value)),
                                    ),
                                  )),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: _valueField(
                                      context: context,
                                      state: state,
                                      field: "A1",
                                      label: "A1",
                                      hintText: "informe A1",
                                      onChanged: (value) => context.read<Regra3Bloc>().add(Regra3ValueA1Changed(value)),
                                    ),
                                  )),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: _valueField(
                                      context: context,
                                      state: state,
                                      field: "B",
                                      label: "B",
                                      hintText: "informe B",
                                      onChanged: (value) => context.read<Regra3Bloc>().add(Regra3ValueBChanged(value)),
                                    ),
                                  )),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: _valueField(
                                        context: context,
                                        state: state,
                                        field: "B1",
                                        label: "B1",
                                        hintText: "informe B1",
                                        onChanged: (value) => context.read<Regra3Bloc>().add(Regra3ValueB1Changed(value)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              _calcButton(context, state),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                BlocBuilder<Regra3Bloc, Regra3State>(
                  builder: (context, state) {
                    if (state is Regra3StateError) {
                      return CardResult.error(text: state.error);
                    }

                    if (state is Regra3StateResult) {
                      return CardResult.valid(text: state.result);
                    }

                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _valueField({
    required BuildContext context,
    required Regra3State state,
    required String field,
    required String label,
    required String hintText,
    required void Function(String value) onChanged,
  }) {
    late bool isFieldNull;
    if (state is Regra3StateResult) {
      isFieldNull = state.fieldX == field;
      if (isFieldNull) {
        _controllerText.text = state.valueX.toString();
      } else {
        isFieldNull = false;
      }
    } else {
      isFieldNull = false;
    }

    return InputText(
      enabled: state is! Regra3StateLoading,
      hintText: hintText,
      label: label,
      fillColor: isFieldNull ? Theme.of(context).colorScheme.inversePrimary : null,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"^\d+\.?\d*"))],
      controller: isFieldNull ? _controllerText : null,
      onChange: onChanged,
    );
  }

  Widget _calcButton(BuildContext context, Regra3State state) {
    final bool isLoading = state is Regra3StateLoading;
    final bool reset = !isLoading && (state is Regra3StateError || state is Regra3StateResult);
    String label = reset ? "Limpar" : "Calcular";

    return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: LoadingButton(
          onPressed: isLoading ? null : () => _onPressedCalcButton(context, reset),
          isLoading: isLoading,
          label: label,
        ));
  }

  void _onPressedCalcButton(BuildContext context, bool reset) {
    if (reset) {
      context.read<Regra3Bloc>().add(Regra3Reset());
      _formKey.currentState?.reset();
      _controllerText.clear();
    } else {
      context.read<Regra3Bloc>().add(Regra3Calc());
    }
  }
}
