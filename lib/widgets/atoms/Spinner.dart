import 'package:flutter/material.dart';

class AtomSpinner extends StatefulWidget {
  const AtomSpinner({super.key});

  @override
  State<AtomSpinner> createState() => _AtomSpinnerState();
}

class _AtomSpinnerState extends State<AtomSpinner>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool determinate = false;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: controller.value,
      semanticsLabel: '찾는중...',
    );
  }
}
