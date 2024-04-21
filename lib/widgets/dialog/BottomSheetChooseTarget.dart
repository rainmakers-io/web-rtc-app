import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/constants/Colors.dart';
import 'package:web_rtc_app/constants/Fonts.dart';
import 'package:web_rtc_app/widgets/atoms/CardButton.dart';
import 'package:web_rtc_app/widgets/atoms/FillButton.dart';

List<String> targets = ['ALL', 'FEMALE', 'MALE'];
List<String> targetValues = ['모두', '여성', '남성'];

class DialogBottomSheetChooseTarget {
  static close() {
    Get.back();
  }

  static show(
      {required Function(String targetSex) onPressedNext, required sex}) {
    String targetSex = sex;

    Get.bottomSheet(
      StatefulBuilder(builder: (context, setState) {
        onChange(String value) {
          setState(() {
            targetSex = value;
          });
        }

        return BottomSheet(
          sex: targetSex,
          onChange: onChange,
        );
      }),
      enableDrag: false,
    ).whenComplete(() => onPressedNext(targetSex));
  }
}

class BottomSheet extends StatelessWidget {
  final String sex;
  final Function(String targetSex) onChange;

  const BottomSheet({
    super.key,
    required this.sex,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
          color: const Color(ColorContent.content1),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('어떤 성별과 만날까요?',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: FontTitleSemibold02.size,
                            fontWeight: FontTitleSemibold02.weight)),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        AtomCardButton(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            borderColor: sex == targets[0]
                                ? const Color(ColorBase.primary)
                                : const Color(ColorContent.content3),
                            backgroundColor: sex == targets[0]
                                ? const Color(ColorBase.primary)
                                    .withOpacity(0.33)
                                : Colors.transparent,
                            onPressed: () {
                              onChange(targets[0]);
                            },
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                        height: 36,
                                        width: 36,
                                        image: AssetImage(
                                            'assets/images/woman-red-hair.png')),
                                    Image(
                                        height: 36,
                                        width: 36,
                                        image: AssetImage(
                                            'assets/images/man-blond-hair.png')),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  targetValues[0],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: FontBodySemibold01.size,
                                      fontWeight: FontBodySemibold01.weight),
                                ),
                              ],
                            )),
                        const SizedBox(
                          width: 12,
                        ),
                        AtomCardButton(
                            borderColor: sex == targets[1]
                                ? const Color(ColorBase.primary)
                                : const Color(ColorContent.content3),
                            backgroundColor: sex == targets[1]
                                ? const Color(ColorBase.primary)
                                    .withOpacity(0.33)
                                : Colors.transparent,
                            onPressed: () {
                              onChange(targets[1]);
                            },
                            child: Column(
                              children: [
                                const Image(
                                    height: 36,
                                    width: 36,
                                    image: AssetImage(
                                        'assets/images/woman-red-hair.png')),
                                const SizedBox(height: 8),
                                Text(
                                  targetValues[1],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: FontBodySemibold01.size,
                                      fontWeight: FontBodySemibold01.weight),
                                ),
                              ],
                            )),
                        const SizedBox(
                          width: 12,
                        ),
                        AtomCardButton(
                            borderColor: sex == targets[2]
                                ? const Color(ColorBase.primary)
                                : const Color(ColorContent.content3),
                            backgroundColor: sex == targets[2]
                                ? const Color(ColorBase.primary)
                                    .withOpacity(0.33)
                                : Colors.transparent,
                            onPressed: () {
                              onChange(targets[2]);
                            },
                            child: Column(
                              children: [
                                const Image(
                                    height: 36,
                                    width: 36,
                                    image: AssetImage(
                                        'assets/images/man-blond-hair.png')),
                                const SizedBox(height: 8),
                                Text(
                                  targetValues[2],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: FontBodySemibold01.size,
                                      fontWeight: FontBodySemibold01.weight),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 28,
                        ),
                        child: AtomFillButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          text: '선택하기',
                        ))),
              ])),
    );
  }
}
