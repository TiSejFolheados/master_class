import 'package:flutter/material.dart';

void openView({required BuildContext context, required dynamic classe}) {
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
    return classe;
  }));
}

void replaceView({required BuildContext context, required dynamic classe}) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (BuildContext context) {
      return classe;
    },
  ));
}
