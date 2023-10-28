import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
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
                  DatePickerWidget(
                    lastDate: DateTime.now(),
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
                  ),
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
                          backgroundColor: controller.location.value == 'seoul'
                              ? const Color(ColorBase.primary).withOpacity(0.33)
                              : Colors.transparent,
                          onPressed: () {
                            controller.location.value = 'seoul';
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
                          backgroundColor: controller.location.value ==
                                  'gyeonggi'
                              ? const Color(ColorBase.primary).withOpacity(0.33)
                              : Colors.transparent,
                          onPressed: () {
                            controller.location.value = 'gyeonggi';
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
                    ])
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

  var interests = ['게임', '캠핑', '헬스장', '노래방'];

  bool selectedLabel(String label) {
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
    return Obx(() => Center(
            child: Column(children: [
          Text('요즘 관심사 ${controller.myInterests.length}/3'),
          Row(
            children: interests.map<Widget>((label) {
              return ChoiceChip(
                label: Text(label),
                selected: selectedLabel(label),
                onSelected: (value) {
                  if (value) {
                    controller.addInterest(label);
                  } else {
                    controller.removeInterest(label);
                  }
                },
              );
            }).toList(),
          ),
          FilledButton(
              onPressed: () {
                if (controller.myInterests.length == 3) {
                  controller.next();
                }
              },
              child: const Text('다음'))
        ])));
  }
}

class Purpose extends GetView<CtlSelectMyInfo> {
  Purpose({super.key});

  var purposes = ['진지한 연애', '커피 한잔', '캐쥬얼한 친구', '술 한잔'];

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      const Text('만남 목적 1개'),
      Row(
        children: purposes.map<Widget>((label) {
          return FilledButton(
            child: Text(label),
            onPressed: () {
              controller.purpose.value = label;
            },
          );
        }).toList(),
      ),
      FilledButton(
          onPressed: () {
            if (controller.purpose.value.isNotEmpty) {
              controller.next();
            }
          },
          child: const Text('다음'))
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

  // TODO: 중간에 나갔을 때의 UX처리 구현 이 페이지에 왔을 때 저장되어있는 값이 있다면 그 다음 페이지로 이동한다.
  // 이전 버튼도 있으면 좋을 듯

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
