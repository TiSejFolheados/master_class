abstract class ImcEvent {}

class ImcPesoChanged extends ImcEvent {
  final double? peso;

  ImcPesoChanged(String value) : peso = value.isEmpty ? null : double.parse(value);
}

class ImcAlturaChanged extends ImcEvent {
  final double? altura;

  ImcAlturaChanged(String value) : altura = value.isEmpty ? null : double.parse(value);
}

class ImcReset extends ImcEvent {}

class ImcCalc extends ImcEvent {}
