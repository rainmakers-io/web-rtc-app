import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/controller/SelectMyInfo.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:web_rtc_app/utils/ImageSelection.dart';

class Sex extends GetView<CtlSelectMyInfo> {
  const Sex({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      const Text('내 성별을 알려주세요.'),
      Row(children: [
        FilledButton(
            onPressed: () {
              controller.sex.value = 'M';
            },
            child: const Text('남')),
        FilledButton(
            onPressed: () {
              controller.sex.value = 'F';
            },
            child: const Text('여'))
      ]),
      FilledButton(onPressed: controller.next, child: const Text('다음'))
    ]));
  }
}

class BirthDay extends GetView<CtlSelectMyInfo> {
  const BirthDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      SizedBox(
          height: 250,
          child: ScrollDatePicker(
              selectedDate: controller.birthDay.value,
              locale: const Locale('ko'),
              onDateTimeChanged: (DateTime value) {
                controller.birthDay.value = value;
              })),
      FilledButton(onPressed: controller.next, child: const Text('다음'))
    ]));
  }
}

class Location extends GetView<CtlSelectMyInfo> {
  const Location({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Row(
        children: [
          FilledButton(
              onPressed: () {
                controller.location.value = '서울';
              },
              child: const Text('서울')),
          FilledButton(
              onPressed: () {
                controller.location.value = '경기';
              },
              child: const Text('경기'))
        ],
      ),
      FilledButton(onPressed: controller.next, child: const Text('다음'))
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
            onPressed: () => Get.offAllNamed('/video-chat'),
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
        body: Column(children: [controller.steps[controller.step.value]])));
  }
}
