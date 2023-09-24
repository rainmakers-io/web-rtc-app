import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/pages/Guide.dart';
import 'package:web_rtc_app/pages/Home.dart';
import 'package:web_rtc_app/pages/SelectMyInfo.dart';
import 'package:web_rtc_app/utils/localStorage.dart';

void displaySplashScreen(cb) {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  cb();
  Future.delayed(const Duration(seconds: 1), () {
    try {
      FlutterNativeSplash.remove();
    } catch (error) {
      // 웹 에서는 splash screen을 껐으므로 관련 에러 발생시 아무것도 하지 않는다...
      // HACK: 콘솔 창에서 에러는 계속 나고있음 왜?
    }
  });
}

void main() {
  displaySplashScreen(() {
    // 세로 화면 고정
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // app bar 스타일 설정
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light));
    runApp(const RootApp());
  });
}

// 사용자 정보 받기
// 권한 받는 기능
// 딥링크

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  String buildInitialRoute() {
    String route = '';

    bool enableForceUpdate = false;
    // bool enableGuide = LocalStorage().storage.getBool('enableGuide') ?? false;
    bool enableGuide = true;

    // ignore: dead_code
    if (enableForceUpdate) {
      // TODO: 강제 업데이트 되도록 유도한다.
    } else if (enableGuide) {
      route = '/guide';
    }

    return route;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => PageHome()),
        GetPage(name: '/guide', page: () => PageGuide()),
        GetPage(name: '/select-my-info', page: () => PageSelectMyInfo()),
      ],
      initialRoute: buildInitialRoute(),
    );
  }
}
