import 'package:flutter/material.dart';
import 'package:web_rtc_app/constants/User.dart';
import 'package:web_rtc_app/constants/Colors.dart';
import 'package:web_rtc_app/constants/Fonts.dart';
import 'package:web_rtc_app/widgets/atoms/CardButton.dart';
import 'package:web_rtc_app/widgets/atoms/FillButton.dart';
import 'package:web_rtc_app/widgets/atoms/IconButton.dart';

class DialogBottomSheetMatchingFilter {
  static show(BuildContext context,
      {required Function(String sex, String location, List<String> ageRange)
          next,
      required sex,
      required location,
      required ageRange}) {
    String _sex = sex;
    String _location = location;
    List<String> _ageRange = ageRange;

    return showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            onChangeSex(String sex) {
              setState(() {
                _sex = sex;
              });
            }

            onChangeLocation(String location) {
              setState(() {
                _location = location;
              });
            }

            onChangeAgeRange(List<String> ageRange) {
              setState(() {
                _ageRange = ageRange;
              });
            }

            // TODO: 파라메터 줄 일수있는 방법 없을까...
            return BottomSheet(
              sex: _sex,
              location: _location,
              ageRange: _ageRange,
              onChangeSex: onChangeSex,
              onChangeLocation: onChangeLocation,
              onChangeAgeRange: onChangeAgeRange,
              onPressedNext: next,
            );
          });
        });
  }
}

class BottomSheet extends StatelessWidget {
  final String sex;
  final String location;
  final List<String> ageRange;
  final Function(String sex) onChangeSex;
  final Function(String location) onChangeLocation;
  final Function(List<String> ageRange) onChangeAgeRange;
  final Function(String sex, String location, List<String> ageRange)
      onPressedNext;

  const BottomSheet({
    super.key,
    required this.sex,
    required this.location,
    required this.ageRange,
    required this.onChangeSex,
    required this.onChangeLocation,
    required this.onChangeAgeRange,
    required this.onPressedNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(ColorContent.content1),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
                              Navigator.of(context).pop();
                            }))),
                const SizedBox(
                  height: 16,
                ),
                const Text('어떤 친구와 만날까요?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: FontTitleSemibold02.size,
                        fontWeight: FontTitleSemibold02.weight)),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('친구 지역',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: FontBodyBold01.size,
                            fontWeight: FontBodyBold01.weight)),
                    const SizedBox(
                      height: 16,
                    ),
                    DropdownButton(
                      value: location,
                      items: ConstantUser.locations
                          .map((item) => DropdownMenuItem(
                              value: item.$1, child: Text(item.$2)))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          onChangeLocation(value);
                        }
                      },
                      underline: Container(
                        height: 2,
                        color: const Color(ColorContent.content3),
                      ),
                      dropdownColor: const Color(ColorContent.content3),
                      isExpanded: true,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: FontBodyBold01.size,
                          fontWeight: FontBodyBold01.weight),
                    ),
                    const SizedBox(height: 48),
                    const Text('친구 성별',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: FontBodyBold01.size,
                            fontWeight: FontBodyBold01.weight)),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        AtomCardButton(
                          padding: const EdgeInsets.all(0),
                          borderColor: sex == ConstantUser.sexOptions[0].$1
                              ? const Color(ColorBase.primary)
                              : const Color(ColorContent.content3),
                          backgroundColor: sex == ConstantUser.sexOptions[0].$1
                              ? const Color(ColorBase.primary).withOpacity(0.33)
                              : Colors.transparent,
                          onPressed: () {
                            onChangeSex(ConstantUser.sexOptions[0].$1);
                          },
                          child: Text(
                            ConstantUser.sexOptions[0].$2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: FontBodySemibold01.size,
                                fontWeight: FontBodySemibold01.weight),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        AtomCardButton(
                          padding: const EdgeInsets.all(0),
                          borderColor: sex == ConstantUser.sexOptions[1].$1
                              ? const Color(ColorBase.primary)
                              : const Color(ColorContent.content3),
                          backgroundColor: sex == ConstantUser.sexOptions[1].$1
                              ? const Color(ColorBase.primary).withOpacity(0.33)
                              : Colors.transparent,
                          onPressed: () {
                            onChangeSex(ConstantUser.sexOptions[1].$1);
                          },
                          child: Text(
                            ConstantUser.sexOptions[1].$2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: FontBodySemibold01.size,
                                fontWeight: FontBodySemibold01.weight),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        AtomCardButton(
                          padding: const EdgeInsets.all(0),
                          borderColor: sex == ConstantUser.sexOptions[2].$1
                              ? const Color(ColorBase.primary)
                              : const Color(ColorContent.content3),
                          backgroundColor: sex == ConstantUser.sexOptions[2].$1
                              ? const Color(ColorBase.primary).withOpacity(0.33)
                              : Colors.transparent,
                          onPressed: () {
                            onChangeSex(ConstantUser.sexOptions[2].$1);
                          },
                          child: Text(
                            ConstantUser.sexOptions[2].$2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: FontBodySemibold01.size,
                                fontWeight: FontBodySemibold01.weight),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('친구 나이대',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: FontBodyBold01.size,
                                fontWeight: FontBodyBold01.weight)),
                        Text(
                            '${double.parse(ageRange[0]).round().toString()}~${double.parse(ageRange[1]).round().toString()}세',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Color(ColorGrayScale.bf),
                                fontSize: FontCaptionMedium02.size,
                                fontWeight: FontCaptionMedium02.weight)),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SliderTheme(
                        data: SliderThemeData(
                            overlayShape: SliderComponentShape.noThumb,
                            rangeTickMarkShape: null,
                            activeTrackColor: const Color(ColorBase.primary),
                            thumbColor: const Color(ColorGrayScale.fa),
                            activeTickMarkColor: const Color(ColorBase.primary),
                            inactiveTrackColor:
                                const Color(ColorContent.content3),
                            inactiveTickMarkColor:
                                const Color(ColorContent.content3),
                            rangeThumbShape: const RoundRangeSliderThumbShape(
                                enabledThumbRadius: 15),
                            disabledThumbColor: const Color(ColorGrayScale.fa)),
                        child: RangeSlider(
                          values: RangeValues(double.parse(ageRange[0]),
                              double.parse(ageRange[1])),
                          onChanged: (range) {
                            onChangeAgeRange([
                              range.start.round().toString(),
                              range.end.round().toString()
                            ]);
                          },
                          labels: RangeLabels(
                            ageRange[0],
                            ageRange[1],
                          ),
                          divisions: 10,
                          min: 14,
                          max: 99,
                        ))
                  ],
                ),
              ]),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 28,
                      ),
                      child: AtomFillButton(
                        onPressed: () {
                          onPressedNext(sex, location, ageRange);
                          Navigator.of(context).pop();
                        },
                        text: '적용하기',
                      ))),
            ]));
  }
}
