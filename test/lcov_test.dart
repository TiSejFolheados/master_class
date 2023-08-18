import 'package:flutter_test/flutter_test.dart';
import 'package:master_class/lcov.dart';

void main(){
  test("Lcov", (){
    final Lcov lcov = Lcov.init();
    lcov.fileReports.forEach(print);
    print("${lcov.coverage()}%");


  });
}