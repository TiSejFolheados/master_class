import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:master_class/modulo_0/cpf/cpf_bloc.dart';
import 'package:master_class/modulo_0/cpf/cpf_bloc_event.dart';
import 'package:master_class/modulo_0/cpf/cpf_bloc_state.dart';
import 'package:master_class/util/widget/appbar_default.dart';
import 'package:master_class/util/widget/loading_button.dart';
import 'package:master_class/util/widget/card_result.dart';
import 'package:master_class/util/widget/input_text.dart';

class CpfPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final maskNumber = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  CpfPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CpfBloc(),
      child: Scaffold(
        appBar: const AppBarDefault("Valida CPF").build(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const Text("Valide o CPF"),
                Card(
                  child: Form(
                    key: _formKey,
                    child: BlocBuilder<CpfBloc, CpfState>(builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            _numberField(),
                            _validateButton(context, state),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                BlocBuilder<CpfBloc, CpfState>(
                  builder: (context, state) {
                    if (state is CpfStateError) {
                      return CardResult.error(text: state.error);
                    }
                    if (state is CpfStateCpfInvalid) {
                      return const CardResult.invalid(text: "CPF Inválido!");
                    }
                    if (state is CpfStateCpfValid) {
                      return const CardResult.valid(text: "CPF Válido!");
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
      builder: (context, state) {
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
          validator: (value) => state.isValidNumber
              ? state is CpfStateValidationError
                  ? "O número informado não é válido!"
                  : null
              : "O campo CPF é obrigatório!",
          onChange: (value) => context.read<CpfBloc>().add(CpfNumberChanged(value)),
        );
      },
    );
  }

  Widget _validateButton(BuildContext context, CpfState state) {
    final isLoading = state is CpfStateLoading;
    final reset = !isLoading && (state is CpfStateError || state is CpfStateCpfValid || state is CpfStateCpfInvalid);
    final label = reset ? "Limpar" : "Validar CPF";
    return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: LoadingButton(
          onPressed: isLoading ? null : () => _onPressedValidateButton(context, reset),
          isLoading: isLoading,
          label: label,
        ));
  }

  void _onPressedValidateButton(BuildContext context, bool reset) {
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
