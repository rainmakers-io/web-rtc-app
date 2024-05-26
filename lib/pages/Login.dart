import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/constants/Colors.dart';
import 'package:web_rtc_app/constants/Fonts.dart';
import 'package:web_rtc_app/controller/Login.dart';
import 'package:flutter/foundation.dart';

class PageLogin extends GetView<CtlLogin> {
  const PageLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(ColorContent.content1),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/login-background.png"),
                    fit: BoxFit.cover)),
            child: SafeArea(
                child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 60, left: 24, right: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FilledButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0xFFFEE500))),
                            onPressed: () => controller.kakaoLogin(),
                            child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          "assets/images/kakaotalk.png"),
                                      width: 24,
                                      height: 24,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      '카카오톡으로 시작하기',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: FontBodySemibold01.size,
                                          fontWeight:
                                              FontBodySemibold01.weight),
                                    ),
                                  ],
                                ))),
                        Visibility(
                          // visible: !kIsWeb && Platform.isIOS,
                          visible: true,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              FilledButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.white)),
                                  onPressed: () => controller.appleLogin(),
                                  child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                "assets/images/apple.png"),
                                            width: 24,
                                            height: 24,
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            '애플로 로그인',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    FontBodySemibold01.size,
                                                fontWeight:
                                                    FontBodySemibold01.weight),
                                          ),
                                        ],
                                      )))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                '가입 시 ',
                                style: TextStyle(
                                    color: Color(ColorGrayScale.bf),
                                    fontSize: FontCaptionMedium02.size,
                                    fontWeight: FontCaptionMedium02.weight),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero),
                                onPressed: () {
                                  controller.goTerms(Uri.parse(
                                      'https://www.notion.so/Haze-a10b7e591a96452abeeb4a2db574fec4'));
                                },
                                child: const DecoratedBox(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color:
                                                    Color(ColorGrayScale.bf)))),
                                    child: Text(
                                      '서비스 이용약관',
                                      style: TextStyle(
                                          color: Color(ColorGrayScale.bf),
                                          fontSize: FontCaptionMedium02.size,
                                          fontWeight:
                                              FontCaptionMedium02.weight),
                                    )),
                              ),
                              const Text(
                                ' 및 ',
                                style: TextStyle(
                                    color: Color(ColorGrayScale.bf),
                                    fontSize: FontCaptionMedium02.size,
                                    fontWeight: FontCaptionMedium02.weight),
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero),
                                  onPressed: () {
                                    controller.goTerms(Uri.parse(
                                        'https://www.notion.so/5ec591e8defc4e6589a6b10ef5e5e703'));
                                  },
                                  child: const DecoratedBox(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color:
                                                    Color(ColorGrayScale.bf)))),
                                    child: Text('개인정보 취급방침',
                                        style: TextStyle(
                                            color: Color(ColorGrayScale.bf),
                                            fontSize: FontCaptionMedium02.size,
                                            fontWeight:
                                                FontCaptionMedium02.weight)),
                                  )),
                              const Text(
                                '에 동의하게 돼요.',
                                style: TextStyle(
                                    color: Color(ColorGrayScale.bf),
                                    fontSize: FontCaptionMedium02.size,
                                    fontWeight: FontCaptionMedium02.weight),
                              )
                            ],
                          ),
                        )
                      ],
                    )))));
  }
}
