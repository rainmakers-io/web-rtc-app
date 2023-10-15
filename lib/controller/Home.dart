import 'package:get/get.dart';

late CtlHome ctlHome;

class CtlHome extends GetxController {
  final RxInt _currentPageIndex = 0.obs;

  get currentPageIndex {
    return _currentPageIndex;
  }
}