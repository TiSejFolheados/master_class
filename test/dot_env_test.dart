import 'package:flutter_test/flutter_test.dart';
import 'package:master_class/modulo_0/dot_env/dot_env.dart';

void main() {
  const path = "assets/parameter.env";

  test("Get All", () async {
    dynamic value = await DotEnv(path).read();

    expect(value, isNotEmpty);
  });

  test("Get String", () async {
    const property = "DATABASE_URL";
    dynamic value = await DotEnv(path).read(property: property);

    expect(value, isNotEmpty);
  });

  test("Get bool", () async {
    const property = "IS_ADMIN";
    dynamic value = await DotEnv(path).read(property: property);

    expect(value, isA<bool>());
  });

  test("Get int", () async {
    const property = "REFRESH_TIME";
    dynamic value = await DotEnv(path).read(property: property);

    expect(value, isA<int>());
  });

  test("Get double", () async {
    const property = "DOUBLE_VALUE";
    dynamic value = await DotEnv(path).read(property: property);

    expect(value, isA<double>());
  });
}
