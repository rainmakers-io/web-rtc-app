import 'package:flutter/material.dart';
import 'package:web_rtc_app/utils/Colors.dart';

class AtomCardButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final Color backgroundColor;

  const AtomCardButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 1, color: Color(ColorContent.content3)),
              borderRadius: BorderRadius.circular(8),
            )),
            child: TextButton(
                style: ButtonStyle(
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
