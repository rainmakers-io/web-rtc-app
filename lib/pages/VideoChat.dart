import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/apis/Provider.dart';
import 'package:web_rtc_app/constants/Colors.dart';
import 'package:web_rtc_app/constants/Fonts.dart';
import 'package:web_rtc_app/constants/User.dart';
import 'package:web_rtc_app/controller/VideoChat.dart';
import 'package:web_rtc_app/utils/Timer.dart';
import 'package:web_rtc_app/widgets/atoms/VideoCallTimer.dart';
import 'package:web_rtc_app/widgets/dialog/AlertDefault.dart';
import 'package:web_rtc_app/widgets/dialog/BottomSheetEndVideoCall.dart';

class PageVideoChat extends StatelessWidget {
  final int time = 60 * 5;
  const PageVideoChat({super.key});

  relationCardData(String purpose) {
    if (purpose == ConstantUser.purposes[0][1]) {
      return {
        'label': ConstantUser.purposes[0][0],
        'backgroundColor': const Color(ColorFeature.pink01),
      };
    } else if (purpose == ConstantUser.purposes[1][1]) {
      return {
        'label': ConstantUser.purposes[1][0],
        'backgroundColor': const Color(ColorFeature.green01),
      };
    } else if (purpose == ConstantUser.purposes[2][1]) {
      return {
        'label': ConstantUser.purposes[2][0],
        'backgroundColor': const Color(ColorBase.secondary),
      };
    } else {
      return {
        'label': ConstantUser.purposes[3][0],
        'backgroundColor': const Color(ColorFeature.blue04),
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CtlVideoChat());
    controller.partnerDisconnected = (data) {
      controller.off();
      if (context.mounted) {
        DialogBottomSheetEndVideoCall.show(context,
            message: '통화가 종료됐어요.',
            img: controller.partnerInfo.value['images'][0]);
      }
    };
    controller.onVisible();
    timer.start(time, () {
      controller.off();
      DialogBottomSheetEndVideoCall.show(context,
          message: '시간이 다 되어 통화가 종료됐어요.',
          img: controller.partnerInfo.value['images'][0]);
    });

    return Obx(
      () => Scaffold(
          backgroundColor: const Color(ColorContent.content1),
          body: Stack(
            children: [
              controller.isOnRemoteRenderer.value
                  ? RTCVideoView(
                      controller.remoteRenderer,
                      filterQuality: FilterQuality.low,
                      objectFit:
                          RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    )
                  : const SizedBox(),
              // 가림막
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(color: Colors.black.withOpacity(1))),
                ],
              ),
              // 컨텐츠 래퍼
              SafeArea(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 44,
                                height: 44,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    var result = await DialogAlertDefault.show(
                                      title: '통화를 종료하시겠어요?',
                                      content:
                                          '상대방을 다시는 만날 수 없을 수도 있어요\n통화를 종료할까요?',
                                      okLabel: '나가기',
                                      okBtnColor: ColorBase.danger,
                                      cancelLabel: '취소하기',
                                    );
                                    if (result == 'ok' && context.mounted) {
                                      controller.off();
                                      DialogBottomSheetEndVideoCall.show(
                                          context,
                                          message: '통화가 종료됐어요.',
                                          img: controller
                                              .partnerInfo.value['images'][0]);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  child: const Image(
                                      image: AssetImage(
                                          'assets/images/logout.png')),
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: const BoxDecoration(
                                      color: Color(ColorGrayScale.fa),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(99))),
                                  child: AtomVideoCallTimer(seconds: time)),
                              SizedBox(
                                width: 44,
                                height: 44,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // 유저 차단 확인 및 차단하기, 방 나가기 모달 띄우기
                                    var result = await DialogAlertDefault.show(
                                        title:
                                            '${controller.partnerInfo.value['nickname']}님을 차단할까요?',
                                        content: '차단 후에는 취소할 수 없어요.',
                                        okLabel: '차단하기',
                                        okBtnColor: ColorBase.danger,
                                        cancelLabel: '취소하기',
                                        imageFileName: 'ban.png');
                                    if (result == 'ok') {
                                      await apiProvider.blockLogService
                                          .blockUser({
                                        'userId': controller
                                            .partnerInfo.value['userId']
                                      });

                                      await DialogAlertDefault.show(
                                          title: '차단 완료 됐습니다.',
                                          content: '앞으로 절대 마주치지 않을거에요.',
                                          okLabel: '확인',
                                          imageFileName: 'success-circle.png');
                                      if (!context.mounted) return;
                                      controller.off();
                                      DialogBottomSheetEndVideoCall.show(
                                          context,
                                          message: '통화가 종료됐어요.',
                                          img: controller
                                              .partnerInfo.value['images'][0]);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: const Color(0x8C18181B),
                                  ),
                                  child: const Image(
                                      image: AssetImage(
                                          'assets/images/shield.png')),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 168,
                              width: 112,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.7),
                                      blurRadius: 5.0,
                                      spreadRadius: 0.0,
                                      offset: const Offset(0, 7),
                                    )
                                  ]),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: controller.isOnLocalRenderer.value
                                      ? RTCVideoView(
                                          mirror: true,
                                          controller.localRenderer,
                                          objectFit: RTCVideoViewObjectFit
                                              .RTCVideoViewObjectFitCover,
                                        )
                                      : const SizedBox()),
                            ),
                            const SizedBox(
                              width: 8,
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(controller.partnerInfo.value['nickname'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: FontTitleBold03.size,
                                      fontWeight: FontTitleBold03.weight)),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                  controller.partnerInfo.value['age']
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: FontBodyMedium01.size,
                                      fontWeight: FontBodyMedium01.weight)),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                  ConstantUser.sexOptionsJson[
                                      controller.partnerInfo.value['gender']]!,
                                  style: const TextStyle(
                                      color: Color(ColorGrayScale.d9),
                                      fontSize: FontCaptionMedium03.size,
                                      fontWeight: FontCaptionMedium03.weight)),
                              const SizedBox(width: 8),
                              const Image(
                                  height: 20,
                                  width: 20,
                                  image:
                                      AssetImage('assets/images/location.png')),
                              Text(controller.partnerInfo.value['location']?[0],
                                  style: const TextStyle(
                                      color: Color(ColorGrayScale.d9),
                                      fontSize: FontCaptionMedium03.size,
                                      fontWeight: FontCaptionMedium03.weight)),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: controller.partnerInfo.value['interests']
                                .map<Widget>((item) => Row(children: [
                                      Chip(
                                        label: Text(item,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    FontCaptionSemibold02.size,
                                                fontWeight:
                                                    FontCaptionSemibold02
                                                        .weight)),
                                        backgroundColor:
                                            const Color(ColorGrayScale.h43)
                                                .withOpacity(0.9),
                                        side: BorderSide.none,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16))),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      )
                                    ]))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Chip(
                            label: Text(
                                relationCardData(controller
                                    .partnerInfo.value['purpose'])['label'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: FontCaptionMedium03.size,
                                    fontWeight: FontCaptionMedium03.weight)),
                            backgroundColor: relationCardData(controller
                                .partnerInfo
                                .value['purpose'])['backgroundColor'],
                            side: BorderSide.none,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                          ),
                        ],
                      ),
                    )
                  ])),
            ],
          )),
    );
  }
}
