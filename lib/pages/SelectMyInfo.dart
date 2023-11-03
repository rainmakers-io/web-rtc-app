import 'package:flutter/material.dart';
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
                                  image:
                                      AssetImage('images/woman-red-hair.png')),
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
                                image: AssetImage('images/man-blond-hair.png')),
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
                    bottom: 32,
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
                                    image: AssetImage('images/left-arrow.png')),
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
                    bottom: 32,
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
                                  image: AssetImage('images/left-arrow.png')),
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
                    bottom: 32,
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
    '와인'
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
                                  image: AssetImage('images/left-arrow.png')),
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
                Tags(
                  itemCount: interests.length,
                  itemBuilder: (int index) {
                    final itemLabel = interests[index];
                    return Obx(() => ChoiceChip(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          backgroundColor: const Color(ColorContent.content1),
                          shape: StadiumBorder(
                              side: BorderSide(
                                  color: isSelectedLabel(itemLabel)
                                      ? const Color(ColorBase.primary)
                                      : const Color(ColorContent.content3))),
                          label: Text(itemLabel),
                          labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: FontCaptionSemibold02.size,
                              fontWeight: FontCaptionSemibold02.weight),
                          selected: isSelectedLabel(itemLabel),
                          selectedColor: const Color(0xFF103561),
                          onSelected: (value) {
                            if (value &&
                                controller.myInterests.length < interestLimit) {
                              controller.addInterest(itemLabel);
                            } else {
                              controller.removeInterest(itemLabel);
                            }
                          },
                        ));
                  },
                )
              ]),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 32,
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
                                  image: AssetImage('images/left-arrow.png')),
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
                                              'images/smiling-face-with-heart-eyes.png')),
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
                                            'images/waving-hand.png')),
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
                                              'images/wine-glass.png')),
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
                                            'images/hot-beverage.png')),
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
                    bottom: 32,
                  ),
                  child: Obx(() => AtomFillButton(
                      onPressed: controller.next,
                      text: '다음',
                      isDisable: controller.sex.value.isEmpty))),
            ]));
  }
}

class Nickname extends GetView<CtlSelectMyInfo> {
  Nickname({super.key});

  final _formKey = GlobalKey<FormState>();
  final nicknameCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Form(
            key: _formKey,
            child: Column(children: [
              const Text('닉네임 8자 이하'),
              TextFormField(
                controller: nicknameCtl,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.length > 8) {
                    return '8자 초과 입력';
                  }
                  return null;
                },
              ),
              FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.nickname.value = nicknameCtl.text;
                      controller.next();
                    }
                  },
                  child: const Text('다음'))
            ])));
  }
}

class Photo extends GetView<CtlSelectMyInfo> {
  const Photo({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Center(
            child: Stack(children: [
          Visibility(
              visible: controller.isLoading.value,
              child: const CircularProgressIndicator(
                strokeWidth: 10,
                backgroundColor: Colors.black,
                color: Colors.green,
              )),
          Column(
            children: [
              const Text('사진 최소 1장'),
              Image.network(controller.profileImageUrl.value),
              FilledButton(
                  onPressed: () async {
                    var file = await UtilImageSelection().getImage();
                    if (file == null) return;
                    var fileString = UtilImageSelection().toBase64(file);
                    controller.isLoading.value = true;
                    // TODO: fileString을 서버로 업로드한다.
                    // 업로드 후에 가져온 link 값을 Image로 보여준다.
                    controller.isLoading.value = false;
                    controller.profileImageUrl.value =
                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg';
                  },
                  child: const Text('이미지 추가')),
              Visibility(
                  visible: controller.profileImageUrl.value.length > 0,
                  child: FilledButton(
                      onPressed: controller.next, child: const Text('다음')))
            ],
          )
        ])));
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
