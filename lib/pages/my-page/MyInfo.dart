import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/constants/Colors.dart';
import 'package:web_rtc_app/constants/Fonts.dart';
import 'package:web_rtc_app/controller/MatchingBegin.dart';
import 'package:web_rtc_app/pages/my-page/Terms.dart';
import 'package:web_rtc_app/utils/LocalStorage.dart';

class Item {
  String title;
  Function onClick;
  Item({required this.title, required this.onClick});
}

class PageMyInfo extends StatelessWidget {
  final List<Item> _itemList = [
    Item(
        title: "로그아웃",
        onClick: () {
          localStorage.storage.clear();
          Get.delete<CtlMatchingBegin>(); 
          Get.offAllNamed('/guide');
        }),
    Item(
        title: "Haze 이용약관",
        onClick: () {
          Get.to(PageTerms());
        })
  ];

  PageMyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(ColorContent.content1),
        body: SafeArea(
            child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemCount: _itemList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _itemList[index].onClick();
              },
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                        color: const Color(ColorGrayScale.f0).withOpacity(0.1),
                        width: 1),
                  )),
                  height: 72,
                  child: Text(_itemList[index].title,
                      style: const TextStyle(
                          color: Color(ColorGrayScale.f0),
                          fontSize: FontBodyMedium01.size,
                          fontWeight: FontBodyMedium01.weight))),
            );
          },
        )));
  }
}
