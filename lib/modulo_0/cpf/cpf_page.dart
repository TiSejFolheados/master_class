import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:master_class/modulo_0/cpf/cpf_bloc.dart';
import 'package:master_class/modulo_0/cpf/cpf_bloc_event.dart';
import 'package:master_class/modulo_0/cpf/cpf_bloc_state.dart';
import 'package:master_class/util/widget/button_loading.dart';
import 'package:master_class/util/widget/card_result.dart';
import 'package:master_class/util/widget/input_text.dart';

class CpfPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final MaskTextInputFormatter maskNumber = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  CpfPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CpfBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Valida CPF"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const Text("Valide o CPF"),
                Card(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          _numberField(),
                          _validadeButton(context),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<CpfBloc, CpfState>(
                  builder: (BuildContext context, CpfState state) {
                    if (state is CpfStateError) {
                      return CardResult(
                        text: state.error,
                        isColor: true,
                        isError: true,
                        isValid: false,
                      );
                    }

                    if (state is CpfStateCpfInvalid) {
                      return const CardResult(
                        text: "CPF Inválido!",
                        isColor: true,
                        isError: false,
                        isValid: false,
                      );
                    }
                    if (state is CpfStateCpfValid) {
                      return const CardResult(
                        text: "CPF Válido!",
                        isColor: true,
                        isError: false,
                        isValid: true,
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

  Widget _numberField() {
    return BlocBuilder<CpfBloc, CpfState>(
      builder: (BuildContext context, CpfState state) {
        return InputText(
          enabled: state is! CpfStateLoading,
          hintText: "Digite o CPF",
          label: "CPF",
          suffixIcon: state is CpfStateCpfValid
              ? const Icon(Icons.check, color: Colors.green)
              : state is CpfStateCpfInvalid
                  ? const Icon(Icons.clear, color: Colors.red)
                  : null,
          keyboardType: TextInputType.number,
          inputFormatters: [maskNumber],
          validator: (String? value) => state.isValidNumber
              ? state is CpfStateValidationError
                  ? "O número informado não é válido!"
                  : null
              : "O campo CPF é obrigatório!",
          onChange: (String value) => context.read<CpfBloc>().add(CpfNumberChanged(value)),
        );
      },
    );
  }

  Widget _validadeButton(BuildContext context) {
    return BlocBuilder<CpfBloc, CpfState>(builder: (BuildContext context, CpfState state) {
      final bool isLoading = state is CpfStateLoading;
      final bool reset = !isLoading && (state is CpfStateError || state is CpfStateCpfValid || state is CpfStateCpfInvalid);
      String label = reset ? "Limpar" : "Validar CPF";
      return Padding(
          padding: const EdgeInsets.only(top: 32),
          child: LoadingButton(
            onPressed: isLoading ? null : () => _onPressedValidadeButton(context, reset),
            isLoading: isLoading,
            label: label,
          ));
    });
  }

  void _onPressedValidadeButton(BuildContext context, bool reset) {
    if (reset) {
      context.read<CpfBloc>().add(CpfReset());
      _formKey.currentState?.reset();
    } else {
      if (_formKey.currentState?.validate() ?? false) {
        context.read<CpfBloc>().add(CpfValidate());
      }
    }
  }
}
