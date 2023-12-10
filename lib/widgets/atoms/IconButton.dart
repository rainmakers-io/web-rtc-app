import 'package:flutter/material.dart';
import 'package:web_rtc_app/constants/Colors.dart';

class AtomIconButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final Color backgroundColor;
  final double paddingAll;

  const AtomIconButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.backgroundColor = const Color(ColorGrayScale.h30),
      this.paddingAll = 8.0});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.all(paddingAll),
          backgroundColor: backgroundColor),
      child: child,
    );
  }
}
