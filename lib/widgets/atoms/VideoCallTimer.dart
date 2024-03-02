import 'dart:async';
import 'package:flutter/material.dart';
import 'package:web_rtc_app/constants/Colors.dart';
import 'package:web_rtc_app/constants/Fonts.dart';

class AtomVideoCallTimer extends StatefulWidget {
  final int seconds;
  const AtomVideoCallTimer({super.key, required this.seconds});

  @override
  State<AtomVideoCallTimer> createState() => _AtomVideoCallTimerState();
}

class _AtomVideoCallTimerState extends State<AtomVideoCallTimer> {
  int _seconds = 0;
  bool _isRunning = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    print(widget.seconds);
    _seconds = widget.seconds;
    start();
  }

  void start() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
      });
    });
  }

  void stop() {
    _isRunning = false;
    _timer.cancel();
  }

  void reset() {
    _isRunning = false;
    setState(() {
      _seconds = widget.seconds;
    });
  }

  String format() {
    int minutes = _seconds ~/ 60;
    int sec = _seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    super.dispose();
    stop();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Image(
            width: 16,
            height: 16,
            image: AssetImage('assets/images/clock.png')),
        const SizedBox(
          width: 4,
        ),
        Text(format(),
            style: const TextStyle(
                color: Color(ColorGrayScale.h26),
                fontSize: FontBodyBold01.size,
                fontWeight: FontBodyBold01.weight))
      ],
    );
  }
}
