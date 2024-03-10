import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/controller/Home.dart';
import 'package:web_rtc_app/constants/Colors.dart';

class PageHome extends GetView<CtlHome> {
  PageHome({super.key}) {
    controller.checkLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(ColorContent.content1),
          onTap: (int index) {
            controller.currentPageIndex.value = index;
          },
          currentIndex: controller.currentPageIndex.value,
          items: [
            BottomNavigationBarItem(
                activeIcon: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: const Color(ColorBase.primary)
                                .withOpacity(0.49),
                            spreadRadius: 2,
                            blurRadius: 25)
                      ],
                    ),
                    child: const Image(
                        height: 25,
                        width: 25,
                        image: AssetImage('assets/images/my-home-fill.png'))),
                icon: const Image(
                    height: 25,
                    width: 25,
                    image: AssetImage('assets/images/my-home.png')),
                label: ''),
            BottomNavigationBarItem(
                activeIcon: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: const Color(ColorBase.primary)
                                .withOpacity(0.49),
                            spreadRadius: 2,
                            blurRadius: 25)
                      ],
                    ),
                    child: const Image(
                        height: 25,
                        width: 25,
                        image: AssetImage('assets/images/my-page-fill.png'))),
                icon: const Image(
                    height: 25,
                    width: 25,
                    image: AssetImage('assets/images/my-page.png')),
                label: '')
          ],
        ),
        body: IndexedStack(
          children: controller.items,
          index: controller.currentPageIndex.value,
        )));
  }
}
