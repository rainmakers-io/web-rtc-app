import 'dart:ui';

import 'package:flutter/material.dart';

class SlideAnimation extends StatefulWidget {
  Widget child;
  final void Function(AnimationController ctl) onInit;

  SlideAnimation({
    super.key,
    required this.child,
    required this.onInit,
  });

  @override
  State<StatefulWidget> createState() {
    return _SlideAnimation();
  }
}

class _SlideAnimation extends State<SlideAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animation;
  late AnimationController ctl;

  @override
  void initState() {
    super.initState();
    ctl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    widget.onInit(ctl);

    // 왼쪽 => 오른쪽을 이동하는 슬라이드 애니메이션F
    Tween<Offset> _tween =
        Tween(begin: const Offset(0.0, 0.0), end: const Offset(1.2, 0.0));
    _animation = _tween.animate(
      CurvedAnimation(
        parent: ctl,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _animation, child: widget.child);
  }
}