import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/apis/Provider.dart';
import 'package:web_rtc_app/pages/MatchingBegin.dart';
import 'package:web_rtc_app/pages/MyInfo.dart';
late CtlHome ctlHome;

class CtlHome extends GetxController {
  final RxInt _currentPageIndex = 0.obs;
  static final List<Widget> _items = [PageMatchingBegin(), const PageMyInfo()];

  checkLoggedIn() async {
    await apiProvider.userService.me();
  }

  get currentPageIndex {
    return _currentPageIndex;
  }

  get items {
    return _items;
  }
}
