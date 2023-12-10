import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:web_rtc_app/controller/MatchingRoom.dart';
import 'package:web_rtc_app/constants/Colors.dart';
import 'package:web_rtc_app/constants/Fonts.dart';
import 'package:web_rtc_app/widgets/dialog/BottomSheetChooseTarget.dart';
import 'package:web_rtc_app/widgets/atoms/FillButton.dart';
import 'package:web_rtc_app/widgets/dialog/BottomSheetMatchingFilter.dart';

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

class PageMatchingRoom extends GetView<CtlMatchingRoom> {
  late AnimationController _animationController;

  PageMatchingRoom({super.key});

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
                  controller.isStartAnimation.value = false;
                  DialogBottomSheetChooseTarget.show(context,
                      sex: controller.sex.value, onPressedNext: (targetSex) {
                    controller.saveMatchingFilters(sex: targetSex);
                    _animationController.forward();
                    controller.isStartAnimation.value = true;
                  });
                  controller.onVisible(info);
                },
                child: Container(
                  padding:
                      const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                  child: Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: RTCVideoView(
                            controller.localRenderer,
                            objectFit: RTCVideoViewObjectFit
                                .RTCVideoViewObjectFitCover,
                          )),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(16),
                                  width: 40,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      DialogBottomSheetMatchingFilter.show(
                                          context,
                                          next: (sex, location, ageRange) {
                                        controller.saveMatchingFilters(
                                            sex: sex,
                                            location: location,
                                            ageRange: ageRange);
                                      },
                                          sex: controller.sex.value,
                                          location: controller.location.value,
                                          ageRange: controller.ageRange.value);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      padding: const EdgeInsets.all(8),
                                      backgroundColor: const Color(0x8C18181B),
                                    ),
                                    child: const Image(
                                        image: AssetImage(
                                            'assets/images/filter.png')),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.all(24),
                                child: AtomFillButton(
                                    onPressed: controller.startMatching,
                                    text: '지금 만나기!'))
                          ]),
                      SlideAnimation(
                          onInit: (ctl) => _animationController = ctl,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 8, sigmaY: 8),
                                      child: Container(
                                          color:
                                              Colors.black.withOpacity(0.6))),
                                  AnimatedOpacity(
                                      opacity: controller.isStartAnimation.value
                                          ? 0
                                          : 1,
                                      duration:
                                          const Duration(milliseconds: 3000),
                                      child: const Center(
                                        child: Text(
                                            "걱정마세요.\n내가 공개하기 전까지\n상대방에겐 희미하게 보여요.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    FontBodySemibold02.size,
                                                fontWeight:
                                                    FontBodySemibold02.weight)),
                                      )),
                                ],
                              ))),
                    ],
                  ),
                )))));
  }
}
