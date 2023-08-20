import 'package:flutter/material.dart';
import 'package:master_class/modulo_0/cpf/cpf_page.dart';
import 'package:master_class/modulo_0/dot_env/dot_env_page.dart';
import 'package:master_class/modulo_0/fibonacci/fibonacci_page.dart';
import 'package:master_class/modulo_0/imc/imc_page.dart';
import 'package:master_class/modulo_0/mod10/mod10_page.dart';
import 'package:master_class/modulo_0/regra3/regra3_page.dart';
import 'package:master_class/modulo_0/vigenere/vigenere_page.dart';
import 'package:master_class/util/navigator_util.dart';

class Modulo0MenuPage extends StatelessWidget {
  const Modulo0MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Módulo Zero"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  _menuItem(context: context, textMenu: "IMC", classe: ImcPage()),
                  _menuItem(context: context, textMenu: "Fibonacci", classe: FibonacciPage()),
                  _menuItem(context: context, textMenu: "Regra 3", classe: Regra3Page()),
                  _menuItem(context: context, textMenu: "Valida CPF", classe: CpfPage()),
                  _menuItem(context: context, textMenu: "Valida Cartão", classe: Mod10Page()),
                  _menuItem(context: context, textMenu: "Vigenere", classe: VigenerePage()),
                  _menuItem(context: context, textMenu: "DotEnv", classe: DotEnvPage()),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _menuItem({required BuildContext context, required String textMenu, required dynamic classe}) {
    return InkWell(
      onTap: () => openView(context: context, classe: classe),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(top: 28, bottom: 28, left: 18, right: 18),
            child: Text(textMenu, style: const TextStyle(fontSize: 20)),
          ),
        ),
      ),
    );
  }
}
