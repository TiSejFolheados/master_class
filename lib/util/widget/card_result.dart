import 'package:flutter/material.dart';

class CardResult extends StatelessWidget {
  final bool isColor;
  final bool isError;
  final bool isValid;
  final String text;

  const CardResult({
    super.key,
    this.isColor = false,
    this.isError = false,
    this.isValid = true,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: isColor
            ? isError || !isValid
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.primary
            : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 15,
                color: isColor
                    ? isError || !isValid
                        ? Theme.of(context).colorScheme.errorContainer
                        : Theme.of(context).colorScheme.inversePrimary
                    : null),
          ),
        ),
      ),
    );
  }
}
