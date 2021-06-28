import 'package:englishbookworddiary/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('login complete'),
    );
    // return Scaffold(
    //   body: Center(
    //       child: GetBuilder<GetController>(
    //     init: GetController(),
    //     builder: (controller) {
    //       return Text('${controller.googleUser}');
    //     },
    //   )),
    // );
  }
}
