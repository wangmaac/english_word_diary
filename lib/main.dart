import 'package:englishbookworddiary/controller/controller.dart';
import 'package:englishbookworddiary/pages/loginchecker.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);

  runApp(GetMaterialApp(
    initialBinding: BindingsBuilder(() {
      Get.put(() => GetController()); //이 부분을 추가하면 된다.
    }),
    home: FutureSplash(),
    debugShowCheckedModeBanner: false,
  ));
}

class FutureSplash extends StatefulWidget {
  const FutureSplash({Key? key}) : super(key: key);

  @override
  _FutureSplashState createState() => _FutureSplashState();
}

class _FutureSplashState extends State<FutureSplash> {
  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 10)),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: myBackgroundColor,
              body: Center(
                  child: Image.asset(
                'assets/images/picdic.png',
                fit: BoxFit.contain,
              )),
            );
          } else {
            return LoginChecker();
          }
        });
  }

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      throw Exception(e);
    }
  }
}
