import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web_rtc_app/constants/Colors.dart';
import 'package:web_rtc_app/constants/Fonts.dart';

class AtomFillButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color backgroundColor;
  final bool isDisable;
  final MaterialStateProperty<BorderSide?>? side;
  final EdgeInsetsGeometry padding;
  Timer? timer;
  bool isPressed = false;

  AtomFillButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.backgroundColor = const Color(ColorBase.primary),
      this.side,
      this.padding = const EdgeInsets.all(0),
      this.isDisable = false});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: ButtonStyle(
            side: side,
            backgroundColor: MaterialStatePropertyAll(
                isDisable ? const Color(ColorGrayScale.h59) : backgroundColor),
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 16))),
        onPressed: () {
          if (!isDisable && !isPressed) {
            // 여러번 클릭 방지
            timer = Timer(const Duration(seconds: 5), () {
              isPressed = false;
            });
            isPressed = true;
            onPressed();
          }
        },
        child: Padding(
            padding: padding,
            child: Text(
              text,
              style: TextStyle(
                  fontSize: FontBodyBold01.size,
                  fontWeight: FontBodyBold01.weight,
                  color: isDisable
                      ? const Color(ColorGrayScale.h8c)
                      : const Color(ColorGrayScale.fa)),
            )));
  }
}
