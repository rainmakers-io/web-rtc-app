import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/pages/SelectMyInfo.dart';
import 'package:web_rtc_app/utils/LocalStorage.dart';

class Guide1 extends StatelessWidget {
  const Guide1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          const Text('Guide1.'),
          FilledButton(
              onPressed: () => scrollController.animateTo(
                  MediaQuery.of(context).size.width - 100,
                  curve: Curves.linear,
                  duration: const Duration(microseconds: 1000)),
              child: const Text('다음'))
        ]));
  }
}

class Guide2 extends StatelessWidget {
  const Guide2({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          const Text('Guide2.'),
          FilledButton(
              onPressed: () => scrollController.animateTo(
                  MediaQuery.of(context).size.width * 2 - 100,
                  curve: Curves.linear,
                  duration: const Duration(microseconds: 1000)),
              child: const Text('다음'))
        ]));
  }
}

class Guide3 extends StatelessWidget {
  const Guide3({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          const Text('Guide3.'),
          FilledButton(
              onPressed: () => scrollController.animateTo(0 - 100,
                  curve: Curves.linear,
                  duration: const Duration(microseconds: 1000)),
              child: const Text('다음'))
        ]));
  }
}

ScrollController scrollController = ScrollController();

class PageGuide extends StatelessWidget {
  const PageGuide({super.key});

  final List<Widget> guides = const [
    Guide1(),
    Guide2(),
    Guide3(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('HAZE'),
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                localStorage.setBool('enableGuide', false);
                Get.to(const PageSelectMyInfo());
              },
              child: const Text('건너뛰기'))
        ],
      ),
      body: ListView.builder(
        controller: scrollController,
        itemBuilder: (_, index) {
          return guides[index];
        },
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(),
        itemCount: guides.length,
      ),
    ));
  }
}
