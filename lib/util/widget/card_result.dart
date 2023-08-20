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

  const CardResult.error({Key? key, required String text})
      : this(
          key: key,
          isColor: true,
          isError: true,
          isValid: false,
          text: text,
        );

  const CardResult.valid({Key? key, required String text})
      : this(
          key: key,
          isColor: true,
          isError: false,
          isValid: true,
          text: text,
        );

  const CardResult.invalid({Key? key, required String text})
      : this(
          key: key,
          isColor: true,
          isError: false,
          isValid: false,
          text: text,
        );

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
