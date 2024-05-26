import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

late CtlLogin ctlLogin;

class CtlLogin extends GetxController {
  goTerms(Uri url) {
    launchUrl(url, mode: LaunchMode.inAppBrowserView);
  }

  kakaoLogin() async {
    bool isInstalled = await isKakaoTalkInstalled();
    try {
      if (isInstalled) {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공 ${token}');
      } else {
        UserApi.instance.loginWithKakaoAccount();
      }
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }

  appleLogin() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      print('애플로 로그인 성공 ${credential}');
    } catch (error) {
      print("애플 로그인 실패 $error");
    }
  }
}
