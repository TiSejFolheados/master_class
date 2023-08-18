abstract class CpfEvent {}

class CpfNumberChanged extends CpfEvent {
  final String number;

  CpfNumberChanged(this.number);
}

class CpfReset extends CpfEvent {}

class CpfValidate extends CpfEvent {}
