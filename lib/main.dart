import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/apis/Provider.dart';
import 'package:web_rtc_app/controller/Guide.dart';
import 'package:web_rtc_app/controller/Home.dart';
import 'package:web_rtc_app/controller/SelectMyInfo.dart';
import 'package:web_rtc_app/controller/MatchingRoom.dart';
import 'package:web_rtc_app/pages/Guide.dart';
import 'package:web_rtc_app/pages/Health.dart';
import 'package:web_rtc_app/pages/Home.dart';
import 'package:web_rtc_app/pages/SelectMyInfo.dart';
import 'package:web_rtc_app/utils/Config.dart';
import 'package:web_rtc_app/utils/LocalStorage.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // 스플레쉬 스크린 표시
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await localStorage.init();
  await config.init();
  apiProvider.init();
  // 세로 화면 고정
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // app bar 스타일 설정
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light));
  runApp(RootApp());

  // 스플레쉬 스크린 종료
  Future.delayed(const Duration(seconds: 1), () {
    try {
      FlutterNativeSplash.remove();
    } on PlatformException catch (error) {
      // 웹 에서는 splash screen을 껐으므로 관련 에러 발생시 아무것도 하지 않는다...
      // HACK: 콘솔 창에서 에러는 계속 나고있음 왜?
    }
  });
}

// 바텀 네비게이션 구현
// 딥링크
class RootApp extends StatelessWidget {
  const RootApp({super.key});

  String initialRoute() {
    String route = '/home';

    bool enableForceUpdate = false;
    String version = '0.0.1';
    bool enableGuide = localStorage.storage.getBool('enableGuide') ?? true;
    bool enableSelectMyInfo =
        localStorage.storage.getBool('enableSelectMyInfo') ?? true;

    if (enableForceUpdate) {
      // TODO: 강제 업데이트 되도록 유도한다.
    } else if (enableGuide) {
      route = '/guide';
    } else if (enableSelectMyInfo) {
      route = '/select-my-info';
    }

    return route;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'PretendardVariable'),
      getPages: [
        GetPage(name: '/home', page: () => const PageHome()),
        GetPage(name: '/guide', page: () => PageGuide()),
        GetPage(name: '/select-my-info', page: () => const PageSelectMyInfo()),
        GetPage(name: '/health', page: () => const PageHealth())
      ],
      initialBinding: BindingsBuilder(() {
        ctlSelectMyInfo = Get.put<CtlSelectMyInfo>(CtlSelectMyInfo());
        ctlMatchingRoom = Get.put<CtlMatchingRoom>(CtlMatchingRoom());
        ctlHome = Get.put<CtlHome>(CtlHome());
        ctlGuide = Get.put<CtlGuide>(CtlGuide());
      }),
      initialRoute: initialRoute(),
    );
  }
}
