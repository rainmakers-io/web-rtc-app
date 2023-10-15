import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:web_rtc_app/apis/Provider.dart';

class PageHealth extends StatefulWidget {
  const PageHealth({super.key});

  @override
  State<StatefulWidget> createState() => _PageHealth();
}

class _PageHealth extends State<PageHealth> {
  String message = 'WAITING...';
  onVisible(VisibilityInfo info) async {
    try {
      var res = await apiProvider.healthService.checkHealth();
      setState(() {
        message = res?.body.message ?? 'OK';
      });
    } catch (error) {
      setState(() {
        message = 'FAILED';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: VisibilityDetector(
            key: const Key('page-matching-room'),
            onVisibilityChanged: onVisible,
            child: Scaffold(body: Text("health status: $message"))));
  }
}
