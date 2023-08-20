import 'package:flutter_test/flutter_test.dart';
import 'package:master_class/modulo_0/dot_env/dot_env.dart';

void main() {
  const path = "assets/parameter.env";

  test("DotEnv - get String", () async {
    final DotEnv dotEnv = DotEnv(path);
    print(await dotEnv.read());

    const String property = "DATABASE_URL";
    dynamic value = await dotEnv.read(property: property);
    print("-------------------------");
    print("property: $property");
    print("value: $value");
    print("type: ${value.runtimeType}");
  });

  test("DotEnv - get Bool", () async {
    final DotEnv dotEnv = DotEnv(path);
    print(await dotEnv.read());

    const String property = "IS_ADMIN";
    dynamic value = await dotEnv.read(property: property);
    print("-------------------------");
    print("property: $property");
    print("value: $value");
    print("type: ${value.runtimeType}");
  });

  test("DotEnv - get int", () async {
    final DotEnv dotEnv = DotEnv(path);
    print(await dotEnv.read());

    const String property = "REFRESH_TIME";
    dynamic value = await dotEnv.read(property: property);
    print("-------------------------");
    print("property: $property");
    print("value: $value");
    print("type: ${value.runtimeType}");
  });

  test("DotEnv - get double", () async {
    final DotEnv dotEnv = DotEnv(path);
    print(await dotEnv.read());

    const String property = "DOUBLE_VALUE";
    dynamic value = await dotEnv.read(property: property);
    print("-------------------------");
    print("property: $property");
    print("value: $value");
    print("type: ${value.runtimeType}");
  });
}
