import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/constants/Colors.dart';
import 'package:web_rtc_app/constants/Fonts.dart';
import 'package:web_rtc_app/widgets/atoms/FillButton.dart';

class DialogAlertDefault {
  static show({title = '', content = '', okLabel = '확인'}) {
    return Get.dialog(PopScope(
      child: (AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: FontTitleSemibold03.size,
                fontWeight: FontTitleSemibold03.weight,
                color: Colors.white)),
        content: Text(content,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: FontBodyMedium01.size,
                fontWeight: FontBodyMedium01.weight,
                color: Color(ColorGrayScale.bf))),
        backgroundColor: const Color(ColorContent.content2),
        contentPadding:
            const EdgeInsetsDirectional.only(top: 24, start: 24, end: 24),
        actionsPadding: const EdgeInsets.all(24),
        actions: [
          Row(children: [
            Expanded(
                flex: 1,
                child: AtomFillButton(
                  onPressed: () {
                    Get.back(result: 'ok');
                  },
                  text: okLabel,
                ))
          ])
        ],
      )),
    ));
  }
}
