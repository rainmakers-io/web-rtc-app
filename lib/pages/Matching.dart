import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/constants/Fonts.dart';
import 'package:web_rtc_app/constants/User.dart';
import 'package:web_rtc_app/controller/Matching.dart';
import 'package:web_rtc_app/constants/Colors.dart';
import 'package:web_rtc_app/widgets/atoms/IconButton.dart';
import 'package:web_rtc_app/widgets/atoms/Spinner.dart';
import 'package:web_rtc_app/widgets/dialog/AlertDefault.dart';
import 'package:web_rtc_app/widgets/dialog/BottomSheetMatchingSuccess.dart';

class PageMatching extends GetView<CtlMatching> {
  const PageMatching({super.key});

  @override
  Widget build(BuildContext context) {
    var locations = Get.arguments['locations'];
    var ageRange = Get.arguments["ageRange"];
    var sex = Get.arguments['sex'];

    controller.initSocket();
    controller.partnerInfo.listen((info) {
      if (info.isNotEmpty) {
        DialogBottomSheetMatchingSuccess.close();
        DialogBottomSheetMatchingSuccess.show(
          context,
          age: info['age'] ?? 0,
          imgSrc: info['profileUrl'],
          interests: info['interests'],
          location: info['location']?[0],
          nickname: info['nickname'],
          purpose: info['purpose'],
          sex: ConstantUser.sexOptionsJson[info['gender']] ,
          next: controller.acceptMatch,
          pass: controller.declineMatch,
        );
      } else {
        DialogBottomSheetMatchingSuccess.close();
      }
    });

    return Scaffold(
        backgroundColor: const Color(ColorContent.content1),
        body: SafeArea(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 62,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                  height: 36,
                                  width: 36,
                                  child: AtomIconButton(
                                      child: const Image(
                                          height: 24,
                                          width: 24,
                                          image: AssetImage(
                                              'assets/images/logout.png')),
                                      onPressed: () async {
                                        var result =
                                            await DialogAlertDefault.show(
                                          title: '정말 나가시겠습니까?',
                                          content: '지금 나가면 다시는\n못만날 수도 있어요.',
                                          okLabel: '나가기',
                                        );
                                        if (result == 'ok') {
                                          controller.back();
                                        }
                                      })))),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 48, horizontal: 20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  ...locations
                                      .map<Widget>((location) => Row(children: [
                                            Chip(
                                              label: Text(location,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          FontTitleSemibold02
                                                              .size,
                                                      fontWeight:
                                                          FontTitleSemibold02
                                                              .weight)),
                                              backgroundColor: const Color(
                                                  ColorBase.primary),
                                              side: BorderSide.none,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  16))),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            )
                                          ]))
                                      .toList(),
                                  const Text('살고있는',
                                      style: TextStyle(
                                          color: Color(ColorGrayScale.bf),
                                          fontSize: FontTitleMedium02.size,
                                          fontWeight: FontTitleMedium02.weight))
                                ]),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(children: [
                                  Chip(
                                    label: Text(
                                        '${ageRange[0]}~${ageRange[1]}세',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: FontTitleSemibold02.size,
                                            fontWeight:
                                                FontTitleSemibold02.weight)),
                                    backgroundColor:
                                        const Color(ColorContent.content3),
                                    side: BorderSide.none,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  const Text('나이대의',
                                      style: TextStyle(
                                          color: Color(ColorGrayScale.bf),
                                          fontSize: FontTitleMedium02.size,
                                          fontWeight: FontTitleMedium02.weight))
                                ]),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(children: [
                                  Chip(
                                    label: Text(
                                        ConstantUser.sexOptionsJson[sex] ?? '',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: FontTitleSemibold02.size,
                                            fontWeight:
                                                FontTitleSemibold02.weight)),
                                    backgroundColor:
                                        const Color(ColorBase.secondary),
                                    side: BorderSide.none,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  const Text('찾고 있어요.',
                                      style: TextStyle(
                                          color: Color(ColorGrayScale.bf),
                                          fontSize: FontTitleMedium02.size,
                                          fontWeight: FontTitleMedium02.weight))
                                ]),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text('좋은 인연 기대할게요!',
                                    style: TextStyle(
                                        color: Color(ColorGrayScale.bf),
                                        fontSize: FontTitleMedium02.size,
                                        fontWeight: FontTitleMedium02.weight)),
                                const SizedBox(
                                  height: 30,
                                ),
                                const AtomSpinner()
                              ]))
                    ]))));
  }
}
