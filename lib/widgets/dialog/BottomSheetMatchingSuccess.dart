import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:web_rtc_app/constants/Colors.dart';
import 'package:web_rtc_app/constants/Fonts.dart';
import 'package:web_rtc_app/constants/User.dart';
import 'package:web_rtc_app/widgets/atoms/CardButton.dart';
import 'package:web_rtc_app/widgets/atoms/FillButton.dart';
import 'package:web_rtc_app/widgets/atoms/IconButton.dart';

class DialogBottomSheetMatchingSuccess {
  static show(
    BuildContext context, {
    required Function() next,
    required imgSrc,
    required nickname,
    required age,
    required sex,
    required location,
    required interests,
    required purpose,
  }) {
    return showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        useSafeArea: true,
        barrierColor: const Color(ColorContent.content1),
        context: context,
        builder: (context) {
          return BottomSheet(
            imgSrc: imgSrc,
            nickname: nickname,
            age: age,
            sex: sex,
            location: location,
            interests: interests,
            purpose: purpose,
            next: next,
          );
        });
  }
}

class BottomSheet extends StatelessWidget {
  final String nickname;
  final int age;
  final String sex;
  final String location;
  final List<String> interests;
  final String purpose;
  final String imgSrc;

  const BottomSheet({
    super.key,
    required Function() next,
    required this.imgSrc,
    required this.nickname,
    required this.age,
    required this.sex,
    required this.location,
    required this.interests,
    required this.purpose,
  });

  relationCardData() {
    if (purpose == ConstantUser.purposes[0][1]) {
      return {
        'src': 'assets/images/smiling-face-with-heart-eyes.png',
        'label': ConstantUser.purposes[0][0],
        'borderColor': const Color(ColorFeature.pink01),
        'backgroundColor': const Color(ColorFeature.pink01).withOpacity(0.33),
      };
    } else if (purpose == ConstantUser.purposes[1][1]) {
      return {
        'src': 'assets/images/waving-hand.png',
        'label': ConstantUser.purposes[1][0],
        'borderColor': const Color(ColorFeature.green01),
        'backgroundColor': const Color(ColorFeature.green01).withOpacity(0.33),
      };
    } else if (purpose == ConstantUser.purposes[2][1]) {
      return {
        'src': 'assets/images/wine-glass.png',
        'label': ConstantUser.purposes[2][0],
        'borderColor': const Color(ColorBase.secondary),
        'backgroundColor': const Color(ColorBase.secondary).withOpacity(0.33),
      };
    } else {
      return {
        'src': 'assets/images/hot-beverage.png',
        'label': ConstantUser.purposes[3][0],
        'borderColor': const Color(ColorFeature.blue04),
        'backgroundColor': const Color(ColorFeature.blue04).withOpacity(0.33),
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(ColorContent.content1),
        padding: const EdgeInsets.only(bottom: 16, left: 20, right: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 62,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 36,
                                  width: 36,
                                  child: AtomIconButton(
                                      child: const Image(
                                          height: 24,
                                          width: 24,
                                          image: AssetImage(
                                              'assets/images/logout.png')),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }))
                            ])),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Stack(children: [
                              Image.network(
                                imgSrc,
                                width: 120,
                                height: 120,
                              ),
                              BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                  child: Container(color: Colors.white))
                            ]))
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(nickname,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: FontTitleBold02.size,
                                fontWeight: FontTitleBold02.weight)),
                        const SizedBox(width: 4),
                        Text('$age',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: FontTitleMedium03.size,
                                fontWeight: FontTitleMedium03.weight)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(sex,
                            style: const TextStyle(
                                color: Color(ColorGrayScale.d9),
                                fontSize: FontCaptionMedium03.size,
                                fontWeight: FontCaptionMedium03.weight)),
                        const SizedBox(width: 8),
                        const Image(
                            height: 20,
                            width: 20,
                            image: AssetImage('assets/images/location.png')),
                        Text(location,
                            style: const TextStyle(
                                color: Color(ColorGrayScale.d9),
                                fontSize: FontCaptionMedium03.size,
                                fontWeight: FontCaptionMedium03.weight)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: interests
                          .map((item) => Row(children: [
                                Chip(
                                  label: Text(item,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: FontCaptionMedium03.size,
                                          fontWeight:
                                              FontCaptionMedium03.weight)),
                                  backgroundColor:
                                      const Color(ColorContent.content3),
                                  side: BorderSide.none,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))),
                                ),
                                const SizedBox(
                                  width: 8,
                                )
                              ]))
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      FittedBox(
                          child: AtomCardButton(
                              borderColor: relationCardData()['borderColor'],
                              backgroundColor:
                                  relationCardData()['backgroundColor'],
                              onPressed: () {},
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image(
                                        height: 36,
                                        width: 36,
                                        image: AssetImage(
                                            relationCardData()['src'])),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '친구가 찾는 관계',
                                          style: TextStyle(
                                              color: Color(ColorGrayScale.d9),
                                              fontSize:
                                                  FontCaptionMedium02.size,
                                              fontWeight:
                                                  FontCaptionMedium02.weight),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          relationCardData()['label'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: FontBodySemibold02.size,
                                              fontWeight:
                                                  FontBodySemibold02.weight),
                                        ),
                                      ],
                                    )
                                  ])))
                    ]),
                  ]),
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: AtomFillButton(
                      onPressed: () {
                        // TODO: 화상채팅 페이지로 넘기기
                      },
                      text: '이야기시작!',
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
                        // TODO: 화상채팅 페이지로 넘기기
                      },
                      text: '넘기기',
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
