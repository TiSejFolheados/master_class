import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class/modulo_0/vigenere/vigenere_bloc.dart';
import 'package:master_class/modulo_0/vigenere/vigenere_bloc_event.dart';
import 'package:master_class/modulo_0/vigenere/vigenere_bloc_state.dart';
import 'package:master_class/modulo_0/vigenere/vigenere_bloc_state_decode.dart';
import 'package:master_class/modulo_0/vigenere/vigenere_bloc_state_encode.dart';
import 'package:master_class/util/widget/appbar_default.dart';
import 'package:master_class/util/widget/loading_button.dart';
import 'package:master_class/util/widget/card_result.dart';
import 'package:master_class/util/widget/card_rotulo.dart';
import 'package:master_class/util/widget/input_text.dart';
import 'package:master_class/util/widget/property/input_formatter.dart';

class VigenerePage extends StatelessWidget {
  final _formKeyEncode = GlobalKey<FormState>();
  final _formKeyDecode = GlobalKey<FormState>();
  final _controllerKeyEncode = TextEditingController();
  final _controllerTextEncoded = TextEditingController();
  final _controllerTextDecoded = TextEditingController();

  VigenerePage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocProvider(
      create: (context) => VigenereBloc(),
      child: Scaffold(
        appBar: const AppBarDefault("Vigenere").build(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const Text(
                  "Criptografe/Descriptografe Text com Vigenere",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Card(
                  child: Form(
                    key: _formKeyEncode,
                    child: BlocBuilder<VigenereBloc, VigenereState>(builder: (context, state) {
                      return Column(
                        children: [
                          const CardRotulo(leading: "Encode"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                _textEncodeField(context, state.encodeState, theme),
                                const SizedBox(height: 15),
                                _keyEncodeField(context, state.encodeState, theme),
                                const SizedBox(height: 15),
                                _encodedField(context, state.encodeState, theme),
                                _encodeButton(context, state.encodeState),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                BlocBuilder<VigenereBloc, VigenereState>(builder: (BuildContext context, VigenereState state) {
                  final encodeState = state.encodeState;
                  if (encodeState is VigenereStateEncodeError) {
                    return CardResult.error(text: encodeState.error);
                  }
                  return Container();
                }),
                Card(
                  child: Form(
                    key: _formKeyDecode,
                    child: BlocBuilder<VigenereBloc, VigenereState>(builder: (context, state) {
                      return Column(
                        children: [
                          const CardRotulo(leading: "Decode"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                _textDecodeField(context, state.decodeState, theme),
                                const SizedBox(height: 15),
                                _keyDecodeField(context, state.decodeState, theme),
                                const SizedBox(height: 15),
                                _decodedField(context, state.decodeState, theme),
                                _decodeButton(context, state.decodeState),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                BlocBuilder<VigenereBloc, VigenereState>(builder: (context, state) {
                  final decodeState = state.decodeState;
                  if (decodeState is VigenereStateDecodeError) {
                    return CardResult.error(
                      text: decodeState.error,
                    );
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

  Widget _textEncodeField(BuildContext context, VigenereStateEncode stateEncode, ThemeData theme) {
    final isEncoded = stateEncode is VigenereStateEncodeEncoded;
    return InputText(
      enabled: stateEncode is! VigenereStateEncodeLoading,
      readOnly: isEncoded,
      fillColor: isEncoded ? theme.colorScheme.inversePrimary : null,
      hintText: "Informe o texto a ser criptografado",
      label: "Texto",
      keyboardType: TextInputType.text,
      inputFormatters: [UpperCaseTextFormatter()],
      validator: (value) => stateEncode.isValidText ? null : "O texto é obrigatório!",
      onChange: (value) => context.read<VigenereBloc>().add(VigenereTextEncodeChanged(value)),
    );
  }

  Widget _keyEncodeField(BuildContext context, VigenereStateEncode stateEncode, ThemeData theme) {
    final isEncoded = stateEncode is VigenereStateEncodeEncoded;
    if (isEncoded) {
      _controllerKeyEncode.text = stateEncode.key;
    }

    return InputText(
      enabled: stateEncode is! VigenereStateEncodeLoading,
      readOnly: isEncoded,
      fillColor: isEncoded ? theme.colorScheme.inversePrimary : null,
      label: "Key",
      keyboardType: TextInputType.text,
      inputFormatters: [UpperCaseTextFormatter()],
      validator: (value) => stateEncode.isValidKey
          ? stateEncode.isValidKeySize
              ? null
              : "A key deve ter o mesmo tamanho do texto"
          : null,
      controller: isEncoded ? _controllerKeyEncode : null,
      onChange: (value) => context.read<VigenereBloc>().add(VigenereKeyEncodeChanged(value)),
    );
  }

  Widget _encodedField(BuildContext context, VigenereStateEncode stateEncode, ThemeData theme) {
    if (stateEncode is VigenereStateEncodeEncoded) {
      _controllerTextEncoded.text = stateEncode.textEncode;
      return InputText(
        readOnly: true,
        label: "Text Encoded",
        fillColor: theme.colorScheme.inversePrimary,
        textColor: theme.colorScheme.primary,
        keyboardType: TextInputType.text,
        controller: _controllerTextEncoded,
      );
    }
    return Container();
  }

  Widget _encodeButton(BuildContext context, VigenereStateEncode stateEncode) {
    final isLoading = stateEncode is VigenereStateEncodeLoading;
    final reset = !isLoading && stateEncode is VigenereStateEncodeEncoded;
    final label = reset ? "Limpar" : "Encode";
    return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: LoadingButton(
          onPressed: isLoading ? null : () => _onPressedEncodeButton(context, reset),
          isLoading: isLoading,
          label: label,
        ));
  }

  Widget _textDecodeField(BuildContext context, VigenereStateDecode stateDecode, ThemeData theme) {
    final isDecode = stateDecode is VigenereStateDecodeDecoded;
    return InputText(
      enabled: stateDecode is! VigenereStateDecodeLoading,
      readOnly: isDecode,
      fillColor: isDecode ? theme.colorScheme.inversePrimary : null,
      hintText: "Informe o texto a ser descriptografado",
      label: "Texto",
      keyboardType: TextInputType.text,
      inputFormatters: [UpperCaseTextFormatter()],
      validator: (value) => stateDecode.isValidText ? null : "O texto é obrigatório!",
      onChange: (value) => context.read<VigenereBloc>().add(VigenereTextDecodeChanged(value)),
    );
  }

  Widget _keyDecodeField(BuildContext context, VigenereStateDecode stateDecode, ThemeData theme) {
    final isDecode = stateDecode is VigenereStateDecodeDecoded;
    return InputText(
      enabled: stateDecode is! VigenereStateDecodeLoading,
      readOnly: isDecode,
      fillColor: isDecode ? theme.colorScheme.inversePrimary : null,
      label: "Key",
      keyboardType: TextInputType.text,
      inputFormatters: [UpperCaseTextFormatter()],
      validator: (value) => stateDecode.isValidKey
          ? stateDecode.isValidKeySize
              ? null
              : "A key deve ter o mesmo tamanho do texto"
          : null,
      onChange: (value) => context.read<VigenereBloc>().add(VigenereKeyDecodeChanged(value)),
    );
  }

  Widget _decodedField(BuildContext context, VigenereStateDecode stateDecode, ThemeData theme) {
    if (stateDecode is VigenereStateDecodeDecoded) {
      _controllerTextDecoded.text = stateDecode.textDecode;
      return InputText(
        readOnly: true,
        label: "Text Decoded",
        fillColor: theme.colorScheme.inversePrimary,
        textColor: theme.colorScheme.primary,
        keyboardType: TextInputType.text,
        controller: _controllerTextDecoded,
      );
    }
    return Container();
  }

  Widget _decodeButton(BuildContext context, VigenereStateDecode stateDecode) {
    final isLoading = stateDecode is VigenereStateDecodeLoading;
    final reset = !isLoading && stateDecode is VigenereStateDecodeDecoded;
    final label = reset ? "Limpar" : "Decode";
    return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: LoadingButton(
          onPressed: isLoading ? null : () => _onPressedDecodeButton(context, reset),
          isLoading: isLoading,
          label: label,
        ));
  }

  void _onPressedEncodeButton(BuildContext context, bool reset) {
    if (reset) {
      context.read<VigenereBloc>().add(VigenereResetEncode());
      _formKeyEncode.currentState?.reset();
      _controllerKeyEncode.clear();
      _controllerTextEncoded.clear();
    } else {
      if (_formKeyEncode.currentState?.validate() ?? false) {
        context.read<VigenereBloc>().add(VigenereEncode());
      }
    }
  }

  void _onPressedDecodeButton(BuildContext context, bool reset) {
    if (reset) {
      context.read<VigenereBloc>().add(VigenereResetDecode());
      _formKeyDecode.currentState?.reset();
    } else {
      if (_formKeyDecode.currentState?.validate() ?? false) {
        context.read<VigenereBloc>().add(VigenereDecode());
      }
    }
  }
}
