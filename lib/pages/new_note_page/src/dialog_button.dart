import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  const DialogButton(
      {super.key, this.color, this.onPressed, required this.text});

  final Color? color;
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    const buttonFont = TextStyle(fontSize: 14, color: Colors.white);
    return TextButton(
        onPressed: () {
          onPressed?.call();
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              color: color),
          child: Text(
            text,
            style: buttonFont,
            textAlign: TextAlign.center,
          ),
        ));
  }
}
