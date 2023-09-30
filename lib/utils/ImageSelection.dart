import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:web_rtc_app/widgets/dialog/Default.dart';

class UtilImageSelection {
  static final UtilImageSelection _instance = UtilImageSelection._();
  late ImagePicker _imagePicker;

  // constructor for private
  UtilImageSelection._() {
    init();
  }

  factory UtilImageSelection() {
    return _instance;
  }

  init() async {
    _imagePicker = ImagePicker();
  }

  toBase64(XFile file) async {
    List<int> bytes = await file.readAsBytes();
    String fileString = base64.encode(bytes);
    return fileString;
  }

  Future<XFile?> getImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 30);
      return image;
    } on PlatformException catch (error) {
      DialogDefault.alert(
          title: '사진 접근 권한을 허용해주세요.', content: '사진 접근 권한을 허용해야 사진을 넣을 수 있어요.');
      AppSettings.openAppSettings();
    }
  }
}
