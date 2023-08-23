import 'package:flutter/material.dart' as loading_button;

class LoadingButton extends loading_button.StatelessWidget {
  final void Function()? onPressed;
  final bool isLoading;
  final String label;

  const LoadingButton({super.key, required this.onPressed, required this.isLoading, required this.label});

  @override
  loading_button.Widget build(loading_button.BuildContext context) {
    return loading_button.ElevatedButton(
      onPressed: onPressed,
      child: isLoading
          ? loading_button.Row(
              mainAxisSize: loading_button.MainAxisSize.min,
              children: [
                const loading_button.Padding(
                  padding: loading_button.EdgeInsets.only(right: 8),
                  child: loading_button.SizedBox(width: 20, height: 20, child: loading_button.CircularProgressIndicator(strokeWidth: 2)),
                ),
                loading_button.Text(label),
              ],
            )
          : loading_button.Text(label),
    );
  }
}
