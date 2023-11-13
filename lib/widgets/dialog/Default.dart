import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogDefault {
  static alert({title = '', content = '', okLabel = '확인'}) {
    return Get.dialog(WillPopScope(
        child: (AlertDialog(
          title: Text(title),
          content: Text(content),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
                onPressed: () {
                  Get.back(result: 'ok');
                },
                child: Text(okLabel))
          ],
        )),
        onWillPop: () async {
          return false;
        }));
  }
}
