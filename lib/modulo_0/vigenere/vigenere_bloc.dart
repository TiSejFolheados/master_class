import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class/modulo_0/vigenere/vigenere.dart';
import 'package:master_class/modulo_0/vigenere/vigenere_bloc_state_decode.dart';
import 'package:master_class/modulo_0/vigenere/vigenere_bloc_state_encode.dart';
import 'package:master_class/modulo_0/vigenere/vigenere_bloc_event.dart';
import 'package:master_class/modulo_0/vigenere/vigenere_bloc_state.dart';

class VigenereBloc extends Bloc<VigenereEvent, VigenereState> {
  VigenereBloc() : super(VigenereStateInit.init()) {
    on<VigenereTextEncodeChanged>(_textEncodeChanged);
    on<VigenereKeyEncodeChanged>(_keyEncodeChanged);
    on<VigenereTextDecodeChanged>(_textDecodeChanged);
    on<VigenereKeyDecodeChanged>(_keyDecodeChanged);
    on<VigenereEncode>(_encode);
    on<VigenereDecode>(_decode);
    on<VigenereResetEncode>(_resetEncode);
    on<VigenereResetDecode>(_resetDecode);
  }

  void _keyEncodeChanged(VigenereKeyEncodeChanged event, Emitter<VigenereState> emitter) {
    emitter(VigenereStateInit.field(
      state: state,
      encodeState: VigenereStateEncodeInit.field(
        state: state.encodeState,
        key: event.key,
      ),
    ));
  }

  void _textEncodeChanged(VigenereTextEncodeChanged event, Emitter<VigenereState> emitter) {
    emitter(VigenereStateInit.field(
      state: state,
      encodeState: VigenereStateEncodeInit.field(
        state: state.encodeState,
        text: event.text,
      ),
    ));
  }

  void _keyDecodeChanged(VigenereKeyDecodeChanged event, Emitter<VigenereState> emitter) {
    emitter(VigenereStateInit.field(
      state: state,
      decodeState: VigenereStateDecodeInit.field(
        state: state.decodeState,
        key: event.key,
      ),
    ));
  }

  void _textDecodeChanged(VigenereTextDecodeChanged event, Emitter<VigenereState> emitter) {
    emitter(VigenereStateInit.field(
      state: state,
      decodeState: VigenereStateDecodeInit.field(
        state: state.decodeState,
        text: event.text,
      ),
    ));
  }

  void _encode(VigenereEncode event, Emitter<VigenereState> emitter) async {
    try {
      emitter(VigenereStateInit.field(
        state: state,
        encodeState: VigenereStateEncodeLoading(state.encodeState),
      ));

      await Future.delayed(const Duration(seconds: 1));

      final vigenere = Vigenere(text: state.encodeState.text, key: state.encodeState.isValidKeySize ? state.encodeState.key : null);
      final textEncode = vigenere.encode();
      final key = vigenere.key!;

      emitter(VigenereStateInit.field(
          state: state,
          encodeState: VigenereStateEncodeEncoded(
            state: state.encodeState,
            textEncode: textEncode,
            key: key,
          )));
    } catch (e) {
      emitter(VigenereStateInit.field(state: state, encodeState: VigenereStateEncodeError(state.encodeState, e.toString())));
    }
  }

  void _decode(VigenereDecode event, Emitter<VigenereState> emitter) async {
    try {
      emitter(VigenereStateInit.field(
        state: state,
        decodeState: VigenereStateDecodeLoading(state.decodeState),
      ));
      await Future.delayed(const Duration(seconds: 1));

      final vigenere = Vigenere(text: state.decodeState.text, key: state.decodeState.key);
      final textDecode = vigenere.decode();

      emitter(VigenereStateInit.field(
          state: state,
          decodeState: VigenereStateDecodeDecoded(
            state.decodeState,
            textDecode,
          )));
    } catch (e) {
      emitter(VigenereStateInit.field(state: state, decodeState: VigenereStateDecodeError(state.decodeState, e.toString())));
    }
  }

  void _resetEncode(VigenereResetEncode event, Emitter<VigenereState> emitter) {
    emitter(VigenereStateInit(encodeState: VigenereStateEncodeInit.init(), decodeState: state.decodeState));
  }

  void _resetDecode(VigenereResetDecode event, Emitter<VigenereState> emitter) {
    emitter(VigenereStateInit(
      encodeState: state.encodeState,
      decodeState: VigenereStateDecodeInit.init(),
    ));
  }
}
