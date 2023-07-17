import 'package:flutter/material.dart';

class VGap extends StatelessWidget {
  const VGap(this.height, {super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class HGap extends StatelessWidget {
  const HGap(this.width, {super.key});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
