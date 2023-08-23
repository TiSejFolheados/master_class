import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class/modulo_0/dot_env/dot_env_bloc.dart';
import 'package:master_class/modulo_0/dot_env/dot_env_bloc_event.dart';
import 'package:master_class/modulo_0/dot_env/dot_env_bloc_state.dart';
import 'package:master_class/util/widget/appbar_default.dart';
import 'package:master_class/util/widget/loading_button.dart';
import 'package:master_class/util/widget/card_result.dart';
import 'package:master_class/util/widget/input_text.dart';

class DotEnvPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _controllerText = TextEditingController();

  DotEnvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DotEnvBloc(),
      child: Scaffold(
        appBar: const AppBarDefault("DotEnv").build(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const Text("Leitura do arquivo .env"),
                Card(
                  child: Form(
                    key: _formKey,
                    child: BlocBuilder<DotEnvBloc, DotEnvState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              _pathField(context, state),
                              const SizedBox(height: 15),
                              _propertyField(context, state),
                              _readButton(context, state),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                BlocBuilder<DotEnvBloc, DotEnvState>(builder: (context, state) {
                  if (state is DotEnvStateReadProperty) {
                    return CardResult.valid(text: state.result);
                  }

                  if (state is DotEnvStateReadAll) {
                    return CardResult(text: state.readAll);
                  }
                  return Container();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _pathField(BuildContext context, DotEnvState state) {
    _controllerText.text = state.path;
    return InputText(
      enabled: false,
      label: "Path",
      controller: _controllerText,
    );
  }

  Widget _propertyField(BuildContext context, DotEnvState state) {
    return InputText(
      enabled: state is! DotEnvStateLoading,
      hintText: "Informe a Propriedade",
      label: "Property",
      onChange: (value) => context.read<DotEnvBloc>().add(DotEnvPropertyChanged(value)),
    );
  }

  Widget _readButton(BuildContext context, DotEnvState state) {
    final isLoading = state is DotEnvStateLoading;
    final reset = !isLoading && (state is DotEnvStateError || state is DotEnvStateReadAll || state is DotEnvStateReadProperty);
    final label = reset ? "Limpar" : "Read";

    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: LoadingButton(
        onPressed: isLoading ? null : () => _onPressedReadButton(context, reset),
        isLoading: isLoading,
        label: label,
      ),
    );
  }

  void _onPressedReadButton(BuildContext context, bool reset) {
    if (reset) {
      context.read<DotEnvBloc>().add(DotEnvReset());
      _formKey.currentState?.reset();
    } else {
      context.read<DotEnvBloc>().add(DotEnvRead());
    }
  }
}
