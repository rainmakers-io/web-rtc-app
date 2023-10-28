import 'package:flutter/material.dart';
import 'package:web_rtc_app/utils/Colors.dart';

class AtomIconButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final Color backgroundColor;

  const AtomIconButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = const Color(ColorGrayScale.h30),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(8),
        backgroundColor: backgroundColor,
      ),
      child: child,
    );
  }
}
