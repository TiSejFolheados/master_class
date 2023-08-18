import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class/modulo_0/imc/imc_bloc.dart';
import 'package:master_class/modulo_0/imc/imc_bloc_event.dart';
import 'package:master_class/modulo_0/imc/imc_bloc_state.dart';
import 'package:master_class/util/widget/button_loading.dart';
import 'package:master_class/util/widget/card_result.dart';
import 'package:master_class/util/widget/input_text.dart';

class ImcPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ImcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ImcBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("IMC"),
        ),
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
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          _pesoField(),
                          const SizedBox(height: 15),
                          _alturaField(),
                          _calcButton(context),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<ImcBloc, ImcState>(
                  builder: (BuildContext context, ImcState state) {
                    if (state is ImcStateResult) {
                      return Column(
                        children: [
                          CardResult(
                            text: "Seu IMC é de ${state.imc.toStringAsFixed(1)}",
                            isColor: true,
                            isError: false,
                            isValid: true,
                          ),
                          CardResult(
                            text: state.analise,
                            isColor: false,
                          ),
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

  Widget _pesoField() {
    return BlocBuilder<ImcBloc, ImcState>(builder: (BuildContext context, ImcState state) {
      return InputText(
        enabled: state is! ImcStateLoading,
        hintText: "Digite seu peso",
        label: "Peso",
        suffixText: "(kg)",
        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^([0-9]{0,3}\.[0-9]?)|^([0-9]{0,3})'))],
        validator: (String? value) => state.isValidPeso ? null : "O campo Peso é obrigatório!",
        onChange: (String value) => context.read<ImcBloc>().add(ImcPesoChanged(value)),
      );
    });
  }

  Widget _alturaField() {
    return BlocBuilder<ImcBloc, ImcState>(builder: (BuildContext context, ImcState state) {
      return InputText(
        enabled: state is! ImcStateLoading,
        hintText: "Digite sua altura",
        label: "Altura",
        suffixText: "(m)",
        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^([0-2]\.[0-9]{0,2})|^([0-2])'))],
        validator: (String? value) => state.isValidAltura ? null : "O campo Altura é obrigatório!",
        onChange: (String value) => context.read<ImcBloc>().add(ImcAlturaChanged(value)),
      );
    });
  }

  Widget _calcButton(BuildContext context) {
    return BlocBuilder<ImcBloc, ImcState>(builder: (BuildContext context, ImcState state) {
      final bool isLoading = state is ImcStateLoading;
      final bool reset = !isLoading && state is ImcStateResult;
      String label = reset ? "Limpar" : "Calcular IMC";
      return Padding(
          padding: const EdgeInsets.only(top: 32),
          child: LoadingButton(
            onPressed: isLoading ? null : () => _onPressedCalcButton(context, reset),
            isLoading: isLoading,
            label: label,
          ));
    });
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
