import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageGuide extends StatelessWidget {
  PageGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Image(image: AssetImage('assets/images/google.png')),
                const Text(
                  'TITLE',
                ),
                const Text(
                  'SUB_TITLe',
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Get.toNamed('/');
                    },
                    child: const Text('시작하기'))
              ],
            ),
          ),
        );
  }
}
