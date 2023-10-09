import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/controller/HomeCtl.dart';
import 'package:web_rtc_app/pages/MatchingRoom.dart';
import 'package:web_rtc_app/pages/MyInfo.dart';

class PageHome extends GetView<CtlHome> {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              controller.currentPageIndex.value = index;
            },
            selectedIndex: controller.currentPageIndex.value,
            destinations: const <Widget>[
              NavigationDestination(icon: Icon(Icons.home), label: ''),
              NavigationDestination(icon: Icon(Icons.abc_sharp), label: '')
            ],
          ),
          body: [
            PageMatchingRoom(),
            PageMyInfo()
          ][controller.currentPageIndex.value],
        ));
  }
}
