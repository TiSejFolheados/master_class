import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:master_class/modulo_0/imc/imc_page.dart';
import 'package:master_class/modulo_0/modulo0_menu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MasterClass 9',
      theme: FlexThemeData.light(
        colors: const FlexSchemeColor(
          primary: Color(0xff00296b),
          primaryContainer: Color(0xffa0c2ed),
          secondary: Color(0xffd26900),
          secondaryContainer: Color(0xffffd270),
          tertiary: Color(0xff5c5c95),
          tertiaryContainer: Color(0xffc8dbf8),
          appBarColor: Color(0xffc8dcf8),
          error: null,
        ),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        appBarBackground: const Color(0xff00296b),
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useTextTheme: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
      ),
      home: const Modulo0MenuPage(),
    );
  }
}
