import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool isLoading;
  final String label;

  const LoadingButton({super.key, required this.onPressed, required this.isLoading, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: isLoading
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                ),
                Text(label),
              ],
            )
          : Text(label),
    );
  }
}
