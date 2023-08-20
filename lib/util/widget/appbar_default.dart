import 'package:flutter/material.dart';

class AppBarDefault {
  final String text;

  const AppBarDefault(this.text);

  PreferredSizeWidget build() {
    return AppBar(title: Text(text));
  }
}
