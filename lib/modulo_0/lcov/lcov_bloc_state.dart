import 'package:master_class/modulo_0/lcov/lcov.dart';

sealed class LcovState {}

class LcovStateInit extends LcovState {}

class LcovStateLoaded extends LcovState {
  final Lcov lcov;

  LcovStateLoaded(this.lcov);
}

class LcovStateLoading extends LcovState {}

class LcovStateError extends LcovState {
  final String error;

  LcovStateError(String error) : error = error.replaceAll("Exception: ", "");
}
