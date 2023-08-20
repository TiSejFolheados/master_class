import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:master_class/modulo_0/mod10/mod10_bloc.dart';
import 'package:master_class/modulo_0/mod10/mod10_bloc_event.dart';
import 'package:master_class/modulo_0/mod10/mod10_bloc_state.dart';
import 'package:master_class/util/widget/appbar_default.dart';
import 'package:master_class/util/widget/button_loading.dart';
import 'package:master_class/util/widget/card_result.dart';
import 'package:master_class/util/widget/input_text.dart';

class Mod10Page extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _maskNumber = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  Mod10Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Mod10Bloc(),
      child: Scaffold(
        appBar: const AppBarDefault("Valida Cartão").build(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const Text("Valide o Cartão"),
                Card(
                  child: Form(
                    key: _formKey,
                    child: BlocBuilder<Mod10Bloc, Mod10State>(builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            _numberField(context, state),
                            _validadeButton(context, state),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                BlocBuilder<Mod10Bloc, Mod10State>(
                  builder: (BuildContext context, Mod10State state) {
                    if (state is Mod10StateError) {
                      return CardResult.error(text: state.error);
                    }

                    if (state is Mod10StateMod10Invalid) {
                      return const CardResult.invalid(text: "Cartão Inválido!");
                    }
                    if (state is Mod10StateMod10Valid) {
                      return const CardResult.valid(text: "Cartão Válido!");
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

  Widget _numberField(BuildContext context, Mod10State state) {
    return InputText(
      enabled: state is! Mod10StateLoading,
      hintText: "Digite o número do Cartão",
      label: "Cartão Número",
      suffixIcon: state is Mod10StateMod10Valid
          ? const Icon(Icons.check, color: Colors.green)
          : state is Mod10StateMod10Invalid
              ? const Icon(Icons.clear, color: Colors.red)
              : null,
      keyboardType: TextInputType.number,
      inputFormatters: [_maskNumber],
      validator: (String? value) => state.isValidNumber
          ? state is Mod10StateValidationError
              ? "O número informado não é válido!"
              : null
          : "O campo Cartão Número é obrigatório!",
      onChange: (String value) => context.read<Mod10Bloc>().add(Mod10NumberChanged(value)),
    );
  }

  Widget _validadeButton(BuildContext context, Mod10State state) {
    final bool isLoading = state is Mod10StateLoading;
    final bool reset = !isLoading && (state is Mod10StateError || state is Mod10StateMod10Valid || state is Mod10StateMod10Invalid);
    String label = reset ? "Limpar" : "Validar Cartão";
    return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: LoadingButton(
          onPressed: isLoading ? null : () => _onPressedValidadeButton(context, reset),
          isLoading: isLoading,
          label: label,
        ));
  }

  void _onPressedValidadeButton(BuildContext context, bool reset) {
    if (reset) {
      context.read<Mod10Bloc>().add(Mod10Reset());
      _formKey.currentState?.reset();
    } else {
      if (_formKey.currentState?.validate() ?? false) {
        context.read<Mod10Bloc>().add(Mod10Validate());
      }
    }
  }
}
