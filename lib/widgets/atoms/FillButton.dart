import 'package:flutter/material.dart';
import 'package:web_rtc_app/utils/Colors.dart';
import 'package:web_rtc_app/utils/Fonts.dart';

class AtomFillButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final bool isDisable;

  const AtomFillButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.isDisable = false});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(isDisable
                ? const Color(ColorGrayScale.h59)
                : const Color(ColorBase.primary)),
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 16))),
        onPressed: () {
          if (!isDisable) {
            onPressed();
          }
        },
        child: Text(
          text,
          style: TextStyle(
              fontSize: FontBodyBold01.size,
              fontWeight: FontBodyBold01.weight,
              color: isDisable
                  ? const Color(ColorGrayScale.h8c)
                  : const Color(ColorGrayScale.fa)),
        ));
  }
}
