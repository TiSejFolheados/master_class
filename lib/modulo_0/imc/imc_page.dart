import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class/modulo_0/imc/imc_bloc.dart';
import 'package:master_class/modulo_0/imc/imc_bloc_event.dart';
import 'package:master_class/modulo_0/imc/imc_bloc_state.dart';
import 'package:master_class/util/widget/appbar_default.dart';
import 'package:master_class/util/widget/button_loading.dart';
import 'package:master_class/util/widget/card_result.dart';
import 'package:master_class/util/widget/input_text.dart';

class ImcPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ImcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImcBloc(),
      child: Scaffold(
        appBar: const AppBarDefault("IMC").build(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const Text(
                  "Calcule aqui o seu IMC",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  "(Índice de Massa Corporal)",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Card(
                  child: Form(
                    key: _formKey,
                    child: BlocBuilder<ImcBloc, ImcState>(builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            _pesoField(context, state),
                            const SizedBox(height: 15),
                            _alturaField(context, state),
                            _calcButton(context, state),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                BlocBuilder<ImcBloc, ImcState>(
                  builder: (context, state) {
                    if (state is ImcStateResult) {
                      return Column(
                        children: [
                          CardResult.valid(text: "Seu IMC é de ${state.imc.toStringAsFixed(1)}"),
                          CardResult(text: state.analise),
                        ],
                      );
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

  Widget _pesoField(BuildContext context, ImcState state) {
    return InputText(
      enabled: state is! ImcStateLoading,
      hintText: "Digite seu peso",
      label: "Peso",
      suffixText: "(kg)",
      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^([0-9]{0,3}\.[0-9]?)|^([0-9]{0,3})'))],
      validator: (value) => state.isValidPeso ? null : "O campo Peso é obrigatório!",
      onChange: (value) => context.read<ImcBloc>().add(ImcPesoChanged(value)),
    );
  }

  Widget _alturaField(BuildContext context, ImcState state) {
    return InputText(
      enabled: state is! ImcStateLoading,
      hintText: "Digite sua altura",
      label: "Altura",
      suffixText: "(m)",
      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^([0-2]\.[0-9]{0,2})|^([0-2])'))],
      validator: (value) => state.isValidAltura ? null : "O campo Altura é obrigatório!",
      onChange: (value) => context.read<ImcBloc>().add(ImcAlturaChanged(value)),
    );
  }

  Widget _calcButton(BuildContext context, ImcState state) {
    final isLoading = state is ImcStateLoading;
    final reset = !isLoading && state is ImcStateResult;
    final label = reset ? "Limpar" : "Calcular IMC";
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
      context.read<ImcBloc>().add(ImcReset());
      _formKey.currentState?.reset();
    } else {
      if (_formKey.currentState?.validate() ?? false) {
        context.read<ImcBloc>().add(ImcCalc());
      }
    }
  }
}
