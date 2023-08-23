import 'dart:io';

class Lcov {
  static const String _path = "./coverage/lcov.info";
  final List<FileReport> fileReports;

  Lcov(this.fileReports);

  factory Lcov.init() {
    final List<String> content = File(_path).readAsLinesSync();
    final List<FileReport> reports = <FileReport>[];

    String sourceFile = "";
    int linesFound = 0;
    int linesHit = 0;
    List<int> linesVerify = <int>[];
    for (String line in content) {
      if (line == "end_of_record") {
        FileReport fileReport = FileReport(
          sourceFile: sourceFile,
          linesFound: linesFound,
          linesHit: linesHit,
          linesVerify: linesVerify,
        );
        reports.add(fileReport);
        linesVerify = <int>[];
      } else {
        final List<String> columns = line.split(":");
        final String key = columns[0];
        final String value = columns[1];

        switch (key) {
          case "SF":
            sourceFile = value;
            break;

          case "LF":
            linesFound = int.parse(value);
            break;

          case "LH":
            linesHit = int.parse(value);
            break;

          case "DA":
            int verify = int.parse(value.split(",")[1]);
            if (verify == 0) {
              linesVerify.add(int.parse(value.split(",")[0]));
            }
            break;
        }
      }
    }
    return Lcov(reports);
  }

  int coverage() {
    int totalLinesFound = 0;
    int totalLinesHit = 0;

    for (FileReport fileReport in fileReports) {
      totalLinesFound += fileReport.linesFound;
      totalLinesHit += fileReport.linesHit;
    }
    final percent = (totalLinesHit / totalLinesFound) * 100;
    return percent.round();
  }
}

class FileReport {
  final String sourceFile;
  final int linesFound;
  final int linesHit;
  final List<int> linesVerify;

  FileReport({
    required this.sourceFile,
    required this.linesFound,
    required this.linesHit,
    required this.linesVerify,
  });
}
