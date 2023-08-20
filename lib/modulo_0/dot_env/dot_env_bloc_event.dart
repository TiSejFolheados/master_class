sealed class DotEnvEvent {}

class DotEnvPropertyChanged extends DotEnvEvent {
  final String property;

  DotEnvPropertyChanged(this.property);
}

class DotEnvReset extends DotEnvEvent {}

class DotEnvRead extends DotEnvEvent {}
