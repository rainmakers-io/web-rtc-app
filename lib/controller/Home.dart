import 'package:get/get.dart';
import 'package:web_rtc_app/apis/Provider.dart';

late CtlHome ctlHome;

class CtlHome extends GetxController {
  final RxInt _currentPageIndex = 0.obs;

  checkLoggedIn() async {
    await apiProvider.userService.me();
  }

  get currentPageIndex {
    return _currentPageIndex;
  }
}
