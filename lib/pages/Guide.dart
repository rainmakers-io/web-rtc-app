import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:web_rtc_app/controller/Guide.dart';
import 'package:web_rtc_app/constants/Fonts.dart';
import 'package:web_rtc_app/utils/LocalStorage.dart';
import 'package:web_rtc_app/constants/Colors.dart';
import 'package:web_rtc_app/widgets/atoms/FillButton.dart';

class Guide1 extends StatelessWidget {
  const Guide1({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Color(ColorContent.content1),
                ),
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 39),
                    child: const Image(
                      image: AssetImage('assets/images/guide01.png'),
                      width: 330,
                      height: 356,
                    ),
                  ),
                  const Text('불안한 화상채팅 이제그만.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(ColorGrayScale.d9),
                          fontSize: FontTitleBold01.size,
                          fontWeight: FontTitleBold01.weight)),
                  Container(
                      margin: const EdgeInsets.only(top: 12, bottom: 36),
                      child: const Text(
                        '블라인드로 안전하게\n이야기부터 해봐요',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: FontDisplay03.size,
                            fontWeight: FontDisplay03.weight),
                      )),
                ]))));
  }
}

class Guide2 extends GetView<CtlGuide> {
  const Guide2({super.key});

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: const Key('page-guide-guide03'),
        onVisibilityChanged: (info) {
          controller.buttonText.value = '다음';
        },
        child: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Color(ColorContent.content1),
                    ),
                    child: Column(children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 39),
                        child: const Image(
                          image: AssetImage('assets/images/guide02.png'),
                          width: 330,
                          height: 356,
                        ),
                      ),
                      const Text('불안한 화상채팅 이제그만.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(ColorGrayScale.d9),
                              fontSize: FontTitleBold01.size,
                              fontWeight: FontTitleBold01.weight)),
                      Container(
                          margin: const EdgeInsets.only(top: 12, bottom: 36),
                          child: const Text(
                            '서로 동의하에\n얼굴을 공개하세요',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: FontDisplay03.size,
                                fontWeight: FontDisplay03.weight),
                          )),
                    ])))));
  }
}

class Guide3 extends GetView<CtlGuide> {
  const Guide3({super.key});

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: const Key('page-guide-guide03'),
        onVisibilityChanged: (info) {
          controller.buttonText.value = '시작!';
        },
        child: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Color(ColorContent.content1),
                    ),
                    child: Column(children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 39),
                        child: const Image(
                          image: AssetImage('assets/images/guide03.png'),
                          width: 330,
                          height: 356,
                        ),
                      ),
                      const Text('서로 꽤 잘 맞는 것 같나요?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(ColorGrayScale.d9),
                              fontSize: FontTitleBold01.size,
                              fontWeight: FontTitleBold01.weight)),
                      Container(
                          margin: const EdgeInsets.only(top: 12, bottom: 36),
                          child: const Text(
                            '연락처를 교환하고\n직접 만나세요!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: FontDisplay03.size,
                                fontWeight: FontDisplay03.weight),
                          )),
                    ])))));
  }
}

ScrollController scrollController = ScrollController();

class PageGuide extends GetView<CtlGuide> {
  final List<Widget> guides = [
    const Guide1(),
    const Guide2(),
    const Guide3(),
  ];

  PageGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                localStorage.setBool('enableGuide', false);
                Get.toNamed('select-my-info');
              },
              child: const Text('건너뛰기',
                  style: TextStyle(
                    color: Color(ColorGrayScale.h8c),
                    fontSize: FontBodySemibold01.size,
                    fontWeight: FontBodySemibold01.weight,
                  )))
        ],
      ),
      bottomNavigationBar: SafeArea(
          child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Color(ColorContent.content1),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 32,
                    left: 24,
                    right: 24,
                  ),
                  child: Obx(() => AtomFillButton(
                        onPressed: () {
                          int curIndex = (scrollController.offset /
                                  MediaQuery.of(context).size.width)
                              .round();
                          if (curIndex == 0) {
                            scrollController.animateTo(
                                MediaQuery.of(context).size.width,
                                curve: Curves.linear,
                                duration: const Duration(microseconds: 200));
                          } else if (curIndex == 1) {
                            scrollController.animateTo(
                                MediaQuery.of(context).size.width * 2,
                                curve: Curves.linear,
                                duration: const Duration(microseconds: 200));
                            controller.buttonText.value = '시작!';
                          } else if (curIndex == 2) {
                            localStorage.setBool('enableGuide', false);
                            Get.toNamed('select-my-info');
                          }
                        },
                        text: controller.buttonText.value,
                      ))))),
      body: ListView.builder(
        controller: scrollController,
        itemBuilder: (_, index) {
          return guides[index];
        },
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(),
        itemCount: guides.length,
      ),
    );
  }
}
