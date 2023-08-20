import 'package:master_class/modulo_0/vigenere/vigenere_bloc_state_decode.dart';
import 'package:master_class/modulo_0/vigenere/vigenere_bloc_state_encode.dart';

sealed class VigenereState {
  final VigenereStateEncode encodeState;
  final VigenereStateDecode decodeState;

  VigenereState({required this.encodeState, required this.decodeState});

  VigenereState.state(VigenereState state) : this(encodeState: state.encodeState, decodeState: state.decodeState);
}

class VigenereStateInit extends VigenereState {
  VigenereStateInit({required super.encodeState, required super.decodeState});

  VigenereStateInit.init() : super(encodeState: VigenereStateEncodeInit.init(), decodeState: VigenereStateDecodeInit.init());

  VigenereStateInit.field({
    required VigenereState state,
    VigenereStateEncode? encodeState,
    VigenereStateDecode? decodeState,
  }) : this(
          encodeState: encodeState ?? state.encodeState,
          decodeState: decodeState ?? state.decodeState,
        );
}
