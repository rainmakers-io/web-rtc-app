import 'package:flutter/material.dart';
import 'package:web_rtc_app/constants/Colors.dart';

class AtomCardButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;
  final EdgeInsets padding;

  const AtomCardButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = Colors.transparent,
    this.borderColor = const Color(ColorContent.content3),
    this.padding = const EdgeInsets.all(24.0),
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
        fit: FlexFit.tight,
        child: Container(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: borderColor),
              borderRadius: BorderRadius.circular(8),
            )),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: borderColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  onPressed();
                },
                child:
                    Padding(padding: padding, child: Center(child: child)))));
  }
}
