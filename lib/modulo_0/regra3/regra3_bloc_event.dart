abstract class Regra3Event {}

class Regra3ValueAChanged extends Regra3Event {
  final double? valueA;

  Regra3ValueAChanged(String value) : valueA = value.isEmpty ? null : double.parse(value);
}

class Regra3ValueA1Changed extends Regra3Event {
  final double? valueA1;

  Regra3ValueA1Changed(String value) : valueA1 = value.isEmpty ? null : double.parse(value);
}

class Regra3ValueBChanged extends Regra3Event {
  final double? valueB;

  Regra3ValueBChanged(String value) : valueB = value.isEmpty ? null : double.parse(value);
}

class Regra3ValueB1Changed extends Regra3Event {
  final double? valueB1;

  Regra3ValueB1Changed(String value) : valueB1 = value.isEmpty ? null : double.parse(value);
}

class Regra3Reset extends Regra3Event {}

class Regra3Calc extends Regra3Event {}
