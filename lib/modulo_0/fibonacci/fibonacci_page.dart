import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class/modulo_0/fibonacci/fibonacci_bloc.dart';
import 'package:master_class/modulo_0/fibonacci/fibonacci_bloc_event.dart';
import 'package:master_class/modulo_0/fibonacci/fibonacci_bloc_state.dart';
import 'package:master_class/util/widget/appbar_default.dart';
import 'package:master_class/util/widget/loading_button.dart';
import 'package:master_class/util/widget/card_result.dart';
import 'package:master_class/util/widget/input_text.dart';

class FibonacciPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  FibonacciPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FibonacciBloc(),
      child: Scaffold(
        appBar: const AppBarDefault("Fibonacci").build(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const Text(
                  "Gere a Sequência Fibonacci com a quantidade termos desejada",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Card(
                  child: Form(
                    key: _formKey,
                    child: BlocBuilder<FibonacciBloc, FibonacciState>(builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            _termoField(context, state),
                            _generateButton(context, state),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                BlocBuilder<FibonacciBloc, FibonacciState>(
                  builder: (BuildContext context, FibonacciState state) {
                    if (state is FibonacciStateResult) {
                      return CardResult(
                        text: state.sequenciaText,
                        isColor: false,
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

  Widget _termoField(BuildContext context, FibonacciState state) {
    return InputText(
      enabled: state is! FibonacciStateLoading,
      hintText: "Digite a quantidade de termos",
      label: "Termos",
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"^\d{0,2}"))],
      validator: (String? value) => state.isValidTermos
          ? state.isValidTermosSize
              ? null
              : "Defina entre 1 a 93 termos!"
          : "O campo Termo é obrigatório!",
      onChange: (String value) => context.read<FibonacciBloc>().add(FibonacciTermoChanged(value)),
    );
  }

  Widget _generateButton(BuildContext context, FibonacciState state) {
    final isLoading = state is FibonacciStateLoading;
    const label = "Gerar Sequência";
    return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: LoadingButton(
          onPressed: isLoading ? null : () => _onPressedGenerateButton(context),
          isLoading: isLoading,
          label: label,
        ));
  }

  void _onPressedGenerateButton(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<FibonacciBloc>().add(FibonacciGenerate());
    }
  }
}
