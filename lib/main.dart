import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:englishbookworddiary/widgets/loginbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() => runApp(GetMaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(),
          Container(
            padding: const EdgeInsets.all(80),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueGrey,
            ),
            child: Center(
                child: Text(
              ' App Logo',
              style: kMainTextBasic.copyWith(fontSize: 30, fontWeight: FontWeight.w700),
            )),
          ),
          SizedBox(
            height: 135,
          ),
          loginButton('Google 로그인', MediaQuery.of(context).size.width * 0.8, Colors.white,
              Colors.grey[600]),
          loginButton(
              '카카오 로그인', MediaQuery.of(context).size.width * 0.8, Colors.yellow, Colors.black),
        ],
      ),
    ));
  }
}
