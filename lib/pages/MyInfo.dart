import 'package:flutter/material.dart';

class PageMyInfo extends StatelessWidget {
  const PageMyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Center(
        child: Text('my info'),
      ),
    ));
  }
}
