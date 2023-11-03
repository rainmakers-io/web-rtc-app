import 'package:flutter/material.dart';
import 'package:web_rtc_app/utils/Colors.dart';

class AtomCardButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;

  const AtomCardButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = Colors.transparent,
    this.borderColor = const Color(ColorContent.content3),
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1, color: borderColor),
              borderRadius: BorderRadius.circular(8),
            )),
            child: TextButton(
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(backgroundColor),
                    backgroundColor: MaterialStatePropertyAll(backgroundColor),
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 20))),
                onPressed: () {
                  onPressed();
                },
                child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Center(child: child)))));
  }
}
