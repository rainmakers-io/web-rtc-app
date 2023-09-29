import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/controller/SelectMyInfo.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class Sex extends GetView<SelectMyInfoCtl> {
  const Sex({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      const Text('내 성별을 알려주세요.'),
      Row(children: [
        // TODO: 라디오 버튼으로 변경하기
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

class BirthDay extends GetView<SelectMyInfoCtl> {
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

class Location extends GetView<SelectMyInfoCtl> {
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

class PageSelectMyInfo extends GetView<SelectMyInfoCtl> {
  const PageSelectMyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        body: Column(children: [controller.steps[controller.step.value]])));
  }
}
