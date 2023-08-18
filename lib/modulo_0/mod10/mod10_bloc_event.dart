abstract class Mod10Event {}

class Mod10NumberChanged extends Mod10Event {
  final String number;

  Mod10NumberChanged(this.number);
}

class Mod10Reset extends Mod10Event {}

class Mod10Validate extends Mod10Event {}
