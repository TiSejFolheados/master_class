import 'dart:io';

class DotEnv {
  final String pathFile = "assets/parameter.env";

  Future<dynamic> read([String? property]) async {
    File file = File(pathFile);

    if (property != null) {
      return await file.readAsLines().then((List<String> value) {
        for (String line in value) {
          if (line.trim().substring(0, 1) != "#" && line.contains("=")) {
            if (line.trim().substring(0, line.indexOf("=")) == property) {
              String value = line.substring(line.indexOf("=") + 1).trim();

              if (bool.tryParse(value) != null) {
                return bool.parse(value);
              }

              if (int.tryParse(value) != null) {
                return int.parse(value);
              }

              if (double.tryParse(value) != null) {
                return double.parse(value);
              }

              return value.replaceAll("\"", "");
            }
          }
        }
        return null;
      });
    } else {
      return await file.readAsString().then((String value) => value);
    }
  }
}
