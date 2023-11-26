import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:web_rtc_app/controller/MatchingRoom.dart';
import 'package:web_rtc_app/utils/Colors.dart';
import 'package:web_rtc_app/widgets/dialog/BottomSheetChooseTarget.dart';

class PageMatchingRoom extends GetView<CtlMatchingRoom> {
  const PageMatchingRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: const Color(ColorContent.content1),
        appBar: AppBar(
          backgroundColor: const Color(ColorContent.content1),
          elevation: 0,
          bottomOpacity: 0,
          centerTitle: true,
          scrolledUnderElevation: 0,
          // 왼쪽 기본 백버튼 제거
          leading: Container(),
          title: const Image(
            image: AssetImage('assets/images/haze-header-logo.png'),
            width: 54,
            height: 15,
          ),
        ),
        body: SafeArea(
            child: VisibilityDetector(
                key: const Key('page-matching-room'),
                onVisibilityChanged: (info) {
                  DialogBottomSheetChooseTarget.show(context,
                      onPressedNext: (targetSex) {
                        // TODO: 애니메이션 진행 및 매칭버튼 표시
                      });
                  controller.onVisible(info);
                },
                child: Stack(
                  children: [
                    FilledButton(
                        onPressed: controller.ableMatching.value
                            ? controller.startMatching
                            : null,
                        child: const Text('지금 만나기!')),
                    Column(
                      children: [
                        Expanded(child: RTCVideoView(controller.localRenderer))
                      ],
                    )
                  ],
                )))));
  }
}
