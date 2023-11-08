import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/controller/SelectMyInfo.dart';
import 'package:web_rtc_app/utils/Colors.dart';
import 'package:web_rtc_app/utils/Fonts.dart';
import 'package:web_rtc_app/utils/ImageSelection.dart';
import 'package:web_rtc_app/widgets/atoms/FillButton.dart';
import 'package:web_rtc_app/widgets/atoms/CardButton.dart';
import 'package:web_rtc_app/widgets/atoms/IconButton.dart';

class Sex extends GetView<CtlSelectMyInfo> {
  const Sex({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(children: [
                SizedBox(height: 62, width: MediaQuery.of(context).size.width),
                const Text('성별이 어떻게 되세요?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: FontTitleBold01.size,
                        fontWeight: FontTitleBold01.weight)),
                const SizedBox(
                  height: 24,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() => AtomCardButton(
                          borderColor: controller.sex.value == 'F'
                              ? const Color(ColorBase.primary)
                              : const Color(ColorContent.content3),
                          backgroundColor: controller.sex.value == 'F'
                              ? const Color(ColorBase.primary).withOpacity(0.33)
                              : Colors.transparent,
                          onPressed: () {
                            controller.sex.value = 'F';
                          },
                          child: const Column(
                            children: [
                              Image(
                                  height: 36,
                                  width: 36,
                                  image: AssetImage(
                                      'assets/images/woman-red-hair.png')),
                              SizedBox(height: 8),
                              Text(
                                '여성',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontBodySemibold01.size,
                                    fontWeight: FontBodySemibold01.weight),
                              ),
                            ],
                          ))),
                      const SizedBox(
                        width: 16,
                      ),
                      Obx(() => AtomCardButton(
                          borderColor: controller.sex.value == 'M'
                              ? const Color(ColorBase.primary)
                              : const Color(ColorContent.content3),
                          backgroundColor: controller.sex.value == 'M'
                              ? const Color(ColorBase.primary).withOpacity(0.33)
                              : Colors.transparent,
                          onPressed: () {
                            controller.sex.value = 'M';
                          },
                          child: const Column(children: [
                            Image(
                                height: 36,
                                width: 36,
                                image: AssetImage(
                                    'assets/images/man-blond-hair.png')),
                            SizedBox(height: 8),
                            Text(
                              '남성',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontBodySemibold01.size,
                                  fontWeight: FontBodySemibold01.weight),
                            )
                          ])))
                    ]),
              ]),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 28,
                  ),
                  child: Obx(() => AtomFillButton(
                      onPressed: controller.next,
                      text: '다음',
                      isDisable: controller.sex.value.isEmpty))),
            ]));
  }
}

final now = DateTime.now();
final pivotDate = DateTime(now.year - 1, now.month - 1);

class BirthDay extends GetView<CtlSelectMyInfo> {
  const BirthDay({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  SizedBox(
                      height: 62,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AtomIconButton(
                                child: const Image(
                                    height: 24,
                                    width: 24,
                                    image: AssetImage(
                                        'assets/images/left-arrow.png')),
                                onPressed: () {
                                  controller.prev();
                                })
                          ])),
                  const Text('생년월일이 언제신가요?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: FontTitleBold01.size,
                          fontWeight: FontTitleBold01.weight)),
                  const SizedBox(
                    height: 24,
                  ),
                  Obx(() => DatePickerWidget(
                        lastDate: DateTime.now(),
                        initialDate: controller.birthDay.value,
                        dateFormat: 'yyyy/MM/dd',
                        locale: DatePicker.localeFromString('ko'),
                        onChange: (DateTime dateTime, _) {
                          controller.birthDay.value = dateTime;
                        },
                        pickerTheme: const DateTimePickerTheme(
                          backgroundColor: Colors.transparent,
                          itemTextStyle: TextStyle(
                              color: Colors.white,
                              fontSize: FontDisplay03.size,
                              fontWeight: FontDisplay03.weight),
                          dividerColor: Colors.transparent,
                        ),
                      )),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 28,
                  ),
                  child: Obx(() => AtomFillButton(
                      onPressed: controller.next,
                      text: '다음',
                      isDisable:
                          !controller.birthDay.value.isBefore(pivotDate))))
            ]));
  }
}

class Location extends GetView<CtlSelectMyInfo> {
  Location({super.key});

  final locations = ['seoul', 'gyeonggi'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(children: [
                SizedBox(
                    height: 62,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AtomIconButton(
                              child: const Image(
                                  height: 24,
                                  width: 24,
                                  image: AssetImage(
                                      'assets/images/left-arrow.png')),
                              onPressed: () {
                                controller.prev();
                              })
                        ])),
                const Text('어디 거주중이세요?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: FontTitleBold01.size,
                        fontWeight: FontTitleBold01.weight)),
                const SizedBox(
                  height: 24,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() => AtomCardButton(
                          borderColor: controller.location.value == locations[0]
                              ? const Color(ColorBase.primary)
                              : const Color(ColorContent.content3),
                          backgroundColor: controller.location.value ==
                                  locations[0]
                              ? const Color(ColorBase.primary).withOpacity(0.33)
                              : Colors.transparent,
                          onPressed: () {
                            controller.location.value = locations[0];
                          },
                          child: const Text(
                            '서울',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: FontBodySemibold01.size,
                                fontWeight: FontBodySemibold01.weight),
                          ))),
                      const SizedBox(
                        width: 16,
                      ),
                      Obx(() => AtomCardButton(
                          borderColor: controller.location.value == locations[1]
                              ? const Color(ColorBase.primary)
                              : const Color(ColorContent.content3),
                          backgroundColor: controller.location.value ==
                                  locations[1]
                              ? const Color(ColorBase.primary).withOpacity(0.33)
                              : Colors.transparent,
                          onPressed: () {
                            controller.location.value = locations[1];
                          },
                          child: const Column(children: [
                            Text(
                              '경기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontBodySemibold01.size,
                                  fontWeight: FontBodySemibold01.weight),
                            )
                          ])))
                    ]),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    '다른 지역은 추후\n업데이트 예정입니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(ColorGrayScale.h8c),
                        fontSize: FontCaptionMedium02.size,
                        fontWeight: FontCaptionMedium02.weight),
                  ),
                )
              ]),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 28,
                  ),
                  child: Obx(() => AtomFillButton(
                      onPressed: controller.next,
                      text: '다음',
                      isDisable: controller.location.value.isEmpty)))
            ]));
  }
}

class Interests extends GetView<CtlSelectMyInfo> {
  Interests({super.key});

  final interests = [
    '게임',
    '캠핑',
    '헬스장',
    '노래방',
    '여행',
    '카페',
    '호캉스',
    '독서',
    '사진',
    '만화',
    '영화',
    '에니메이션',
    'PC방',
    '치맥',
    '한강',
    '와인',
    '카공',
    '맛집 탐방',
    '주식/투자',
    '음악감상',
    '드라이브',
    '자기계발',
    '요리',
    '드로잉',
    '악기연주',
    '위스키',
  ];
  final interestLimit = 3;

  bool isSelectedLabel(String label) {
    bool result = false;
    for (var selectedLabel in controller.myInterests.value) {
      if (selectedLabel == label) {
        result = true;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(children: [
                SizedBox(
                    height: 62,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AtomIconButton(
                              child: const Image(
                                  height: 24,
                                  width: 24,
                                  image: AssetImage(
                                      'assets/images/left-arrow.png')),
                              onPressed: () {
                                controller.prev();
                              })
                        ])),
                const Text('요즘 관심사는 무엇인가요?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: FontTitleBold01.size,
                        fontWeight: FontTitleBold01.weight)),
                Obx(() => Container(
                    margin: const EdgeInsets.only(bottom: 24, top: 8),
                    child: Text(
                        '${controller.myInterests.length}/${interestLimit}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color(ColorGrayScale.bf),
                            fontSize: FontBodyBold01.size,
                            fontWeight: FontBodyBold01.weight)))),
                SizedBox(
                  // HACK: 남은 공감 스크롤
                    height: MediaQuery.of(context).size.height / 2 + 80,
                    child: SingleChildScrollView(
                        child: Tags(
                      itemCount: interests.length,
                      itemBuilder: (int index) {
                        final itemLabel = interests[index];
                        return Obx(() => ChoiceChip(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              backgroundColor:
                                  const Color(ColorContent.content1),
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color: isSelectedLabel(itemLabel)
                                          ? const Color(ColorBase.primary)
                                          : const Color(
                                              ColorContent.content3))),
                              label: Text(itemLabel),
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: FontCaptionSemibold02.size,
                                  fontWeight: FontCaptionSemibold02.weight),
                              selected: isSelectedLabel(itemLabel),
                              selectedColor: const Color(0xFF103561),
                              onSelected: (value) {
                                if (value &&
                                    controller.myInterests.length <
                                        interestLimit) {
                                  controller.addInterest(itemLabel);
                                } else {
                                  controller.removeInterest(itemLabel);
                                }
                              },
                            ));
                      },
                    ))),
              ]),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 28,
                  ),
                  child: Obx(() => AtomFillButton(
                      onPressed: controller.next,
                      text: '다음',
                      isDisable:
                          controller.myInterests.length < interestLimit)))
            ]));
  }
}

class Purpose extends GetView<CtlSelectMyInfo> {
  Purpose({super.key});

  final purposes = ['진지한 연애', '새로운 친구', '술 한잔', '캐쥬얼한 친구'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(children: [
                SizedBox(
                    height: 62,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AtomIconButton(
                              child: const Image(
                                  height: 24,
                                  width: 24,
                                  image: AssetImage(
                                      'assets/images/left-arrow.png')),
                              onPressed: () {
                                controller.prev();
                              })
                        ])),
                const Text('어떤 관계를 찾고있어요?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: FontTitleBold01.size,
                        fontWeight: FontTitleBold01.weight)),
                const SizedBox(
                  height: 24,
                ),
                Obx(() => Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AtomCardButton(
                                  borderColor:
                                      controller.purpose.value == purposes[0]
                                          ? const Color(ColorFeature.pink01)
                                          : const Color(ColorContent.content3),
                                  backgroundColor:
                                      controller.purpose.value == purposes[0]
                                          ? const Color(ColorFeature.pink01)
                                              .withOpacity(0.33)
                                          : Colors.transparent,
                                  onPressed: () {
                                    controller.purpose.value = purposes[0];
                                  },
                                  child: Column(
                                    children: [
                                      const Image(
                                          height: 36,
                                          width: 36,
                                          image: AssetImage(
                                              'assets/images/smiling-face-with-heart-eyes.png')),
                                      const SizedBox(height: 8),
                                      Text(
                                        purposes[0],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: FontBodySemibold01.size,
                                            fontWeight:
                                                FontBodySemibold01.weight),
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                width: 16,
                              ),
                              AtomCardButton(
                                  borderColor:
                                      controller.purpose.value == purposes[1]
                                          ? const Color(ColorFeature.green01)
                                          : const Color(ColorContent.content3),
                                  backgroundColor:
                                      controller.purpose.value == purposes[1]
                                          ? const Color(ColorFeature.green01)
                                              .withOpacity(0.33)
                                          : Colors.transparent,
                                  onPressed: () {
                                    controller.purpose.value = purposes[1];
                                  },
                                  child: Column(children: [
                                    const Image(
                                        height: 36,
                                        width: 36,
                                        image: AssetImage(
                                            'assets/images/waving-hand.png')),
                                    const SizedBox(height: 8),
                                    Text(
                                      purposes[1],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: FontBodySemibold01.size,
                                          fontWeight:
                                              FontBodySemibold01.weight),
                                    )
                                  ]))
                            ]),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AtomCardButton(
                                  borderColor:
                                      controller.purpose.value == purposes[2]
                                          ? const Color(ColorBase.secondary)
                                          : const Color(ColorContent.content3),
                                  backgroundColor:
                                      controller.purpose.value == purposes[2]
                                          ? const Color(ColorBase.secondary)
                                              .withOpacity(0.33)
                                          : Colors.transparent,
                                  onPressed: () {
                                    controller.purpose.value = purposes[2];
                                  },
                                  child: Column(
                                    children: [
                                      const Image(
                                          height: 36,
                                          width: 36,
                                          image: AssetImage(
                                              'assets/images/wine-glass.png')),
                                      const SizedBox(height: 8),
                                      Text(
                                        purposes[2],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: FontBodySemibold01.size,
                                            fontWeight:
                                                FontBodySemibold01.weight),
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                width: 16,
                              ),
                              AtomCardButton(
                                  borderColor:
                                      controller.purpose.value == purposes[3]
                                          ? const Color(ColorFeature.blue04)
                                          : const Color(ColorContent.content3),
                                  backgroundColor:
                                      controller.purpose.value == purposes[3]
                                          ? const Color(ColorFeature.blue04)
                                              .withOpacity(0.33)
                                          : Colors.transparent,
                                  onPressed: () {
                                    controller.purpose.value = purposes[3];
                                  },
                                  child: Column(children: [
                                    const Image(
                                        height: 36,
                                        width: 36,
                                        image: AssetImage(
                                            'assets/images/hot-beverage.png')),
                                    const SizedBox(height: 8),
                                    Text(
                                      purposes[3],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: FontBodySemibold01.size,
                                          fontWeight:
                                              FontBodySemibold01.weight),
                                    )
                                  ]))
                            ]),
                      ],
                    ))
              ]),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 28,
                  ),
                  child: Obx(() => AtomFillButton(
                      onPressed: controller.next,
                      text: '다음',
                      isDisable: controller.purpose.value.isEmpty))),
            ]));
  }
}

class Nickname extends GetView<CtlSelectMyInfo> {
  Nickname({super.key});

  final _formKey = GlobalKey<FormState>();
  final nicknameCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(children: [
                  SizedBox(
                      height: 62,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AtomIconButton(
                                child: const Image(
                                    height: 24,
                                    width: 24,
                                    image: AssetImage(
                                        'assets/images/left-arrow.png')),
                                onPressed: () {
                                  controller.prev();
                                })
                          ])),
                  const Text('닉네임을 알려주세요',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: FontTitleBold01.size,
                          fontWeight: FontTitleBold01.weight)),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      controller.nickname.value = nicknameCtl.text;
                    },
                    controller: nicknameCtl,
                    textAlign: TextAlign.center,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    maxLength: 8,
                    autofocus: true,
                    style: const TextStyle(
                        fontSize: FontDisplay03.size,
                        fontWeight: FontDisplay03.weight,
                        color: Color(ColorGrayScale.fa)),
                    cursorColor: const Color(ColorBase.primary),
                    decoration: const InputDecoration(
                        errorStyle: TextStyle(
                          color: Color(ColorBase.danger),
                          fontSize: FontCaptionMedium02.size,
                          fontWeight: FontCaptionMedium02.weight,
                        ),
                        counterText: '',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: FontDisplay03.size,
                            fontWeight: FontDisplay03.weight,
                            color: Color(ColorGrayScale.h59)),
                        hintText: '8글자까지 입력가능'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '닉네임을 입력해주세요.';
                      }
                      if (RegExp(r'[^가-힣a-zA-Z0-9]').hasMatch(value)) {
                        return '한글, 영어, 숫자만 입력해주세요.';
                      }
                      return null;
                    },
                  ),
                ]),
                Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 28,
                    ),
                    child: Obx(() => AtomFillButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.nickname.value = nicknameCtl.text;
                            controller.next();
                          }
                        },
                        text: '다음',
                        isDisable: controller.nickname.value.isEmpty)))
              ],
            )));
  }
}

class Photo extends GetView<CtlSelectMyInfo> {
  const Photo({super.key});

  myProfileImage() async {
    var file = await UtilImageSelection().getImage();
    if (file == null) return;
    var fileString = await UtilImageSelection().toBase64(file);
    controller.profileImageFile.value = fileString;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  SizedBox(
                      height: 62,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AtomIconButton(
                                child: const Image(
                                    height: 24,
                                    width: 24,
                                    image: AssetImage(
                                        'assets/images/left-arrow.png')),
                                onPressed: () {
                                  controller.prev();
                                })
                          ])),
                  const Text('프로필 사진을 등록해주세요',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: FontTitleBold01.size,
                          fontWeight: FontTitleBold01.weight)),
                  const SizedBox(
                    height: 24,
                  ),
                  Obx(() => Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 3,
                              color: controller.profileImageFile.value.isEmpty
                                  ? const Color(ColorContent.content3)
                                  : const Color(ColorBase.primary))),
                      child: Stack(
                        children: [
                          Visibility(
                              visible:
                                  controller.profileImageFile.value.isNotEmpty,
                              child: LayoutBuilder(
                                  builder: (context, constraints) => Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.memory(
                                                fit: BoxFit.cover,
                                                height: 160,
                                                width: 160,
                                                base64Decode(controller
                                                    .profileImageFile.value)),
                                          ),
                                          Positioned(
                                              top: 116,
                                              right: -7,
                                              child: AtomIconButton(
                                                  paddingAll: 18,
                                                  child: const Image(
                                                      height: 18,
                                                      width: 18,
                                                      image: AssetImage(
                                                          'assets/images/edit.png')),
                                                  onPressed: () {
                                                    myProfileImage();
                                                  })),
                                        ],
                                      ))),
                          Visibility(
                              visible:
                                  controller.profileImageFile.value.isEmpty,
                              child: Center(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: const CircleBorder(),
                                          padding: const EdgeInsets.all(65),
                                          shadowColor: const Color(
                                              ColorContent.content1),
                                          backgroundColor: const Color(
                                              ColorContent.content1),
                                          foregroundColor: const Color(
                                              ColorContent.content1)),
                                      onPressed: () async {
                                        myProfileImage();
                                      },
                                      child: Image.asset(
                                        'assets/images/plus.png',
                                        height: 26,
                                        width: 26,
                                      )))),
                        ],
                      ))),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text('내가 공개하기 전까지\n상대방에게는 블러 처리돼요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(ColorGrayScale.d9),
                          fontSize: FontCaptionMedium02.size,
                          fontWeight: FontCaptionMedium02.weight)),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 28,
                  ),
                  child: Obx(() => AtomFillButton(
                      onPressed: controller.next,
                      text: '다음',
                      isDisable: controller.profileImageFile.value.isEmpty)))
            ]));
  }
}

class Welcome extends GetView<CtlSelectMyInfo> {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const Text('환영합니다.'),
        FilledButton(
            // TODO: 서버 전송이 완료되면 활성화되도록 수정
            onPressed: () => Get.offAllNamed('/home'),
            child: const Text('다음'))
      ],
    ));
  }
}

class PageSelectMyInfo extends GetView<CtlSelectMyInfo> {
  const PageSelectMyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: const Color(ColorContent.content1),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
              ),
              child: controller.steps[controller.step.value]),
        )));
  }
}
