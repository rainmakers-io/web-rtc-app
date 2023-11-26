import 'package:flutter/material.dart';
import 'package:web_rtc_app/utils/Colors.dart';
import 'package:web_rtc_app/utils/Fonts.dart';
import 'package:web_rtc_app/widgets/atoms/CardButton.dart';
import 'package:web_rtc_app/widgets/atoms/FillButton.dart';

List<(String, String)> targets = [
  ('ALL', '모두'),
  ('FEMALE', '여자'),
  ('MAIL', '남자')
];

class DialogBottomSheetChooseTarget {
  static show(BuildContext context,
      {required Function(String targetSex) onPressedNext}) {
    String sex = targets[0].$1;

    return showModalBottomSheet(
        enableDrag: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            onChange(String value) {
              setState(() {
                sex = value;
              });
            }

            return BottomSheet(
              sex: sex,
              onChange: onChange,
              onPressedNext: onPressedNext,
            );
          });
        }).whenComplete(() => onPressedNext(sex));
  }
}

class BottomSheet extends StatelessWidget {
  final String sex;
  final Function(String targetSex) onChange;
  final Function(String targetSex) onPressedNext;

  const BottomSheet({
    super.key,
    required this.sex,
    required this.onChange,
    required this.onPressedNext,
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
                            borderColor: sex == targets[0].$1
                                ? const Color(ColorBase.primary)
                                : const Color(ColorContent.content3),
                            backgroundColor: sex == targets[0].$1
                                ? const Color(ColorBase.primary)
                                    .withOpacity(0.33)
                                : Colors.transparent,
                            onPressed: () {
                              onChange(targets[0].$1);
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
                                  targets[0].$2,
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
                            borderColor: sex == targets[1].$1
                                ? const Color(ColorBase.primary)
                                : const Color(ColorContent.content3),
                            backgroundColor: sex == targets[1].$1
                                ? const Color(ColorBase.primary)
                                    .withOpacity(0.33)
                                : Colors.transparent,
                            onPressed: () {
                              onChange(targets[1].$1);
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
                                  targets[1].$2,
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
                            borderColor: sex == targets[2].$1
                                ? const Color(ColorBase.primary)
                                : const Color(ColorContent.content3),
                            backgroundColor: sex == targets[2].$1
                                ? const Color(ColorBase.primary)
                                    .withOpacity(0.33)
                                : Colors.transparent,
                            onPressed: () {
                              onChange(targets[2].$1);
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
                                  targets[2].$2,
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
                            onPressedNext(sex);
                            Navigator.of(context).pop();
                          },
                          text: '선택하기',
                        ))),
              ])),
    );
  }
}
