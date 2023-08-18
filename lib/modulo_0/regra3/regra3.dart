class Regra3 {
  final double? valueA;
  final double? valueA1;
  final double? valueB;
  final double? valueB1;

  Regra3({required this.valueA, required this.valueA1, required this.valueB, required this.valueB1});

  String fieldNull() {
    if (valueA != null && valueA1 != null && valueB != null && valueB1 != null) {
      throw Exception("É necessário 1 valor a ser encontrado!");
    }

    String? fieldNull;
    if (valueA == null) {
      fieldNull = "A";
    }

    if (valueA1 == null) {
      if (fieldNull != null) throw Exception("É permitido somente um campo com valor nulo!");
      fieldNull = "A1";
    }

    if (valueB == null) {
      if (fieldNull != null) throw Exception("É permitido somente um campo com valor nulo!");
      fieldNull = "B";
    }

    if (valueB1 == null) {
      if (fieldNull != null) throw Exception("É permitido somente um campo com valor nulo!");
      fieldNull = "B1";
    }
    return fieldNull!;
  }

  double calc(String fieldNull) {
    switch (fieldNull) {
      case "A":
        return (valueB! * valueA1!) / valueB1!;

      case "A1":
        return (valueA! * valueB1!) / valueB!;

      case "B":
        return (valueA! * valueB1!) / valueA1!;

      case "B1":
        return (valueB! * valueA1!) / valueA!;
    }

    return 0;
  }
}
