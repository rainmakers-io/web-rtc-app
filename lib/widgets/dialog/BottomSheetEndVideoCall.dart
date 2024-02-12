import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/constants/Colors.dart';
import 'package:web_rtc_app/constants/Fonts.dart';
import 'package:web_rtc_app/constants/User.dart';
import 'package:web_rtc_app/pages/Matching.dart';
import 'package:web_rtc_app/utils/LocalStorage.dart';
import 'package:web_rtc_app/widgets/atoms/FillButton.dart';
import 'package:web_rtc_app/widgets/atoms/IconButton.dart';

class DialogBottomSheetEndVideoCall {
  static show(BuildContext context, {required img, required message}) {
    String _img = img;
    String _message = message;

    return showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        useSafeArea: true,
        barrierColor: const Color(ColorContent.content1),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return BottomSheet(
              img: _img,
              message: _message,
            );
          });
        });
  }
}

class BottomSheet extends StatelessWidget {
  final String img;
  final String message;

  const BottomSheet({
    super.key,
    required this.img,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    String sex = localStorage.storage.getString('matching.sex') ??
        ConstantUser.sexOptions[0].$1;
    List<String> locations =
        localStorage.storage.getStringList('matching.locations') ??
            [ConstantUser.locations[0].$2];
    List<String> ageRange =
        localStorage.storage.getStringList('matching.ageRange') ?? ['14', '99'];

    return Container(
        color: const Color(ColorContent.content1),
        padding: const EdgeInsets.only(bottom: 16, left: 20, right: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                    height: 62,
                    child: SizedBox(
                        height: 36,
                        width: 36,
                        child: AtomIconButton(
                            child: const Image(
                                height: 24,
                                width: 24,
                                image: AssetImage('assets/images/close.png')),
                            onPressed: () {
                              Get.off('/home');
                            }))),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Stack(children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: Image.network(
                              img,
                              semanticLabel: '프로필 이미지',
                            ),
                          ),
                          BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(color: Colors.white))
                        ]))
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(message,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: FontTitleSemibold02.size,
                        fontWeight: FontTitleSemibold02.weight)),
              ]),
              Column(
                children: [
                  const Text('다른 사람도 한번 만나볼까요?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(ColorGrayScale.d9),
                          fontSize: FontCaptionMedium02.size,
                          fontWeight: FontCaptionMedium02.weight)),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: AtomFillButton(
                      onPressed: () {
                        Get.off(const PageMatching(), arguments: {
                          'sex': sex,
                          'locations': locations,
                          'ageRange': ageRange
                        });
                      },
                      text: '다시 매칭하기',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: AtomFillButton(
                      backgroundColor: const Color(ColorContent.content1),
                      onPressed: () {
                        Get.off('/home');
                      },
                      text: '나중에 할게요',
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                ],
              )
            ]));
  }
}
