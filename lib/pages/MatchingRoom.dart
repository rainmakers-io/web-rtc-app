import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:web_rtc_app/controller/MatchingRoom.dart';

class PageMatchingRoom extends GetView<CtlMatchingRoom> {
  PageMatchingRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
        child: Scaffold(
            body: VisibilityDetector(
                key: const Key('page-matching-room'),
                onVisibilityChanged: controller.onVisible,
                child: Stack(
                  children: [
                    FilledButton(
                        onPressed: controller.ableMatching.value
                            ? controller.startMatching
                            : null,
                        child: const Text('매칭 시작!')),
                    Column(
                      children: [
                        Expanded(child: RTCVideoView(controller.localRenderer))
                      ],
                    )
                  ],
                )))));
  }
}
