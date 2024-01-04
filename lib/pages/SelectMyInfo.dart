import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/constants/User.dart';
import 'package:web_rtc_app/controller/SelectMyInfo.dart';
import 'package:web_rtc_app/constants/Colors.dart';
import 'package:web_rtc_app/constants/Fonts.dart';
import 'package:web_rtc_app/utils/ImageSelection.dart';
import 'package:web_rtc_app/widgets/atoms/FillButton.dart';
import 'package:web_rtc_app/widgets/atoms/CardButton.dart';
import 'package:web_rtc_app/widgets/atoms/IconButton.dart';
import 'package:web_rtc_app/widgets/dialog/AlertDefault.dart';

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
                          borderColor: controller.sex.value == 'FEMALE'
                              ? const Color(ColorBase.primary)
                              : const Color(ColorContent.content3),
                          backgroundColor: controller.sex.value == 'FEMALE'
                              ? const Color(ColorBase.primary).withOpacity(0.33)
                              : Colors.transparent,
                          onPressed: () {
                            controller.sex.value = 'FEMALE';
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
                          borderColor: controller.sex.value == 'MALE'
                              ? const Color(ColorBase.primary)
                              : const Color(ColorContent.content3),
                          backgroundColor: controller.sex.value == 'MALE'
                              ? const Color(ColorBase.primary).withOpacity(0.33)
                              : Colors.transparent,
                          onPressed: () {
                            controller.sex.value = 'MALE';
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
  const Location({super.key});

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
                          borderColor: controller.location.value ==
                                  ConstantUser.locations[0].$2
                              ? const Color(ColorBase.primary)
                              : const Color(ColorContent.content3),
                          backgroundColor: controller.location.value ==
                                  ConstantUser.locations[0].$2
                              ? const Color(ColorBase.primary).withOpacity(0.33)
                              : Colors.transparent,
                          onPressed: () {
                            controller.location.value =
                                ConstantUser.locations[0].$2;
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
                          borderColor: controller.location.value ==
                                  ConstantUser.locations[1].$2
                              ? const Color(ColorBase.primary)
                              : const Color(ColorContent.content3),
                          backgroundColor: controller.location.value ==
                                  ConstantUser.locations[1].$2
                              ? const Color(ColorBase.primary).withOpacity(0.33)
                              : Colors.transparent,
                          onPressed: () {
                            controller.location.value =
                                ConstantUser.locations[1].$2;
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
    '음악 감상',
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
                        '${controller.myInterests.length}/$interestLimit',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color(ColorGrayScale.bf),
                            fontSize: FontBodyBold01.size,
                            fontWeight: FontBodyBold01.weight)))),
                SizedBox(
                    // 남은 공간만 스크롤, 추후 좀 더 잘 구현해보기
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

  final purposes = [
    ['진지한 연애', '진지한연애'],
    ['새로운 친구', '새로운친구'],
    ['술 한잔', '술한잔'],
    ['캐쥬얼한 친구', '캐쥬얼한친구'],
  ];

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
                                      controller.purpose.value == purposes[0][1]
                                          ? const Color(ColorFeature.pink01)
                                          : const Color(ColorContent.content3),
                                  backgroundColor:
                                      controller.purpose.value == purposes[0][1]
                                          ? const Color(ColorFeature.pink01)
                                              .withOpacity(0.33)
                                          : Colors.transparent,
                                  onPressed: () {
                                    controller.purpose.value = purposes[0][1];
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
                                        purposes[0][0],
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
                                      controller.purpose.value == purposes[1][1]
                                          ? const Color(ColorFeature.green01)
                                          : const Color(ColorContent.content3),
                                  backgroundColor:
                                      controller.purpose.value == purposes[1][1]
                                          ? const Color(ColorFeature.green01)
                                              .withOpacity(0.33)
                                          : Colors.transparent,
                                  onPressed: () {
                                    controller.purpose.value = purposes[1][1];
                                  },
                                  child: Column(children: [
                                    const Image(
                                        height: 36,
                                        width: 36,
                                        image: AssetImage(
                                            'assets/images/waving-hand.png')),
                                    const SizedBox(height: 8),
                                    Text(
                                      purposes[1][0],
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
                                      controller.purpose.value == purposes[2][1]
                                          ? const Color(ColorBase.secondary)
                                          : const Color(ColorContent.content3),
                                  backgroundColor:
                                      controller.purpose.value == purposes[2][1]
                                          ? const Color(ColorBase.secondary)
                                              .withOpacity(0.33)
                                          : Colors.transparent,
                                  onPressed: () {
                                    controller.purpose.value = purposes[2][1];
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
                                        purposes[2][0],
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
                                      controller.purpose.value == purposes[3][1]
                                          ? const Color(ColorFeature.blue04)
                                          : const Color(ColorContent.content3),
                                  backgroundColor:
                                      controller.purpose.value == purposes[3][1]
                                          ? const Color(ColorFeature.blue04)
                                              .withOpacity(0.33)
                                          : Colors.transparent,
                                  onPressed: () {
                                    controller.purpose.value = purposes[3][1];
                                  },
                                  child: Column(children: [
                                    const Image(
                                        height: 36,
                                        width: 36,
                                        image: AssetImage(
                                            'assets/images/hot-beverage.png')),
                                    const SizedBox(height: 8),
                                    Text(
                                      purposes[3][0],
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
    if (file == null) {
      DialogAlertDefault.show(title: '프로파일 이미지가 존재하지 않습니다. 새로운 이미지를 추가해주세요.');
      return;
    }
    // 용량 제한 예외처리
    const sizeLimit = 5 * 1024 * 1024;
    if (File(file.path).lengthSync() >= sizeLimit) {
      DialogAlertDefault.show(
          title: '이미지 용량은 5MB를 넘을 수 없습니다.',
          content: '이미지 크기를 줄이거나 다른 이미지를 넣어주세요.');
      return;
    }
    // NOTE: 이미지는 용량 이슈로 인해 유저 생성시 이미지 로컬스토리지에 저장.
    controller.profileImageFile = file;
    controller.profileImageFileString.value =
        await UtilImageSelection().toBase64(file);
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
                              color: controller
                                      .profileImageFileString.value.isEmpty
                                  ? const Color(ColorContent.content3)
                                  : const Color(ColorBase.primary))),
                      child: Stack(
                        children: [
                          Visibility(
                              visible: controller
                                  .profileImageFileString.value.isNotEmpty,
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
                                                    .profileImageFileString
                                                    .value)),
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
                              visible: controller
                                  .profileImageFileString.value.isEmpty,
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
                      onPressed: () async {
                        try {
                          await controller.createNewUser();
                          controller.next();
                        } catch (error) {
                          DialogAlertDefault.show(
                              title:
                                  '일시적인 에러로 서비스를 이용할 수 없습니다.\n잠시후 다시 시도해주세요.',
                              content:
                                  '에러가 지속될 시 "abcd@naver.com"으로 문의주시면 빠르게 해결하겠습니다.');
                          rethrow;
                        }
                      },
                      text: '다음',
                      isDisable:
                          controller.profileImageFileString.value.isEmpty)))
            ]));
  }
}

class Welcome extends GetView<CtlSelectMyInfo> {
  const Welcome({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Image(
                    height: 52,
                    width: 47,
                    image: AssetImage('assets/images/haze-logo-icon.png')),
                const SizedBox(
                  height: 16,
                ),
                Obx(() => Text("${controller.nickname.value}님",
                    style: const TextStyle(
                        color: Color(ColorGrayScale.d9),
                        fontSize: FontTitleBold02.size,
                        fontWeight: FontTitleBold02.weight))),
                const SizedBox(
                  height: 4,
                ),
                const Row(
                  children: [
                    Text("Haze에 오신것을 환영해요!",
                        style: TextStyle(
                            color: Color(ColorGrayScale.d9),
                            fontSize: FontTitleBold02.size,
                            fontWeight: FontTitleBold02.weight)),
                    SizedBox(
                      width: 8,
                    ),
                    Image(
                        height: 24,
                        width: 24,
                        image: AssetImage('assets/images/party-popper.png')),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text("아래 4 가지만 약속해요.",
                    style: TextStyle(
                        color: Color(ColorGrayScale.d9),
                        fontSize: FontCaptionMedium01.size,
                        fontWeight: FontCaptionMedium01.weight)),
                const SizedBox(
                  height: 24,
                ),
                const Image(
                    height: 388,
                    width: 342,
                    image: AssetImage('assets/images/promise-content.png')),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 28,
                ),
                child: AtomFillButton(
                  onPressed: () {
                    Get.offAllNamed('/home');
                  },
                  text: '동의합니다',
                ))
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
