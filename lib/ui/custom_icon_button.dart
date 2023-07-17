import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomIconButton extends ConsumerWidget {
  const CustomIconButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      this.iconPadding = EdgeInsets.zero});

  final IconData icon;
  final VoidCallback onPressed;
  final EdgeInsets iconPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Color(
          0xFF3B3B3B,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: IconButton(
        icon: Padding(
          padding: iconPadding,
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
