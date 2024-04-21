import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/constants/Colors.dart';
import 'package:web_rtc_app/constants/Fonts.dart';
import 'package:web_rtc_app/widgets/atoms/FillButton.dart';

class DialogAlertDefault {
  static show(
      {imageFileName = '',
      title = '',
      content = '',
      okLabel = '확인',
      okBtnColor = ColorBase.primary,
      cancelLabel = ''}) {
    return Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imageFileName.isEmpty
                ? const SizedBox()
                : Image(
                    image: AssetImage('assets/images/$imageFileName'),
                    width: 42,
                    height: 42,
                  ),
            const SizedBox(height: 12),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: FontTitleSemibold03.size,
                    fontWeight: FontTitleSemibold03.weight,
                    color: Colors.white))
          ],
        ),
        content: SizedBox(
            // 바깥 padding 제외
            width: Get.width - 24 - 24,
            child: Text(content,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: FontBodyMedium01.size,
                    fontWeight: FontBodyMedium01.weight,
                    color: Color(ColorGrayScale.bf)))),
        backgroundColor: const Color(ColorContent.content2),
        surfaceTintColor: Colors.transparent,
        contentPadding:
            const EdgeInsetsDirectional.only(top: 24, start: 24, end: 24),
        actionsPadding: const EdgeInsets.all(24),
        actions: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: AtomFillButton(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                    onPressed: () {
                      Get.back(result: 'ok');
                    },
                    backgroundColor: Color(okBtnColor),
                    text: okLabel,
                  )),
            ],
          ),
          SizedBox(height: cancelLabel.isNotEmpty ? 16 : 0),
          cancelLabel.isNotEmpty
              ? Row(children: [
                  Expanded(
                      flex: 1,
                      child: AtomFillButton(
                        onPressed: () {
                          Get.back(result: 'cancel');
                        },
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 5),
                        side: const MaterialStatePropertyAll(BorderSide(
                            width: 1, color: Color(ColorGrayScale.h8c))),
                        backgroundColor: const Color(ColorContent.content2),
                        text: cancelLabel,
                      ))
                ])
              : const SizedBox(),
        ],
      ),
    );
  }
}
