import 'dart:async';
import 'package:flutter/material.dart';
import 'package:web_rtc_app/constants/Colors.dart';
import 'package:web_rtc_app/constants/Fonts.dart';

class AtomVideoCallTimer extends StatefulWidget {
  final int seconds = 60 * 5;
  final Function onStop;
  const AtomVideoCallTimer({super.key, seconds, required this.onStop});

  @override
  State<AtomVideoCallTimer> createState() => _AtomVideoCallTimerState();
}

class _AtomVideoCallTimerState extends State<AtomVideoCallTimer> {
  int _seconds = 0;
  bool _isRunning = false;
  late Timer _timer;

  _AtomVideoCallTimerState() {
    _seconds = widget.seconds;
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
    widget.onStop();
  }

  void reset() {
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
  Widget build(BuildContext context) {
    if (_seconds <= 0) {
      stop();
    }

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
