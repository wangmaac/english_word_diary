import 'package:englishbookworddiary/pages/mainpage.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginChecker extends StatefulWidget {
  const LoginChecker({Key? key}) : super(key: key);

  @override
  _LoginCheckerState createState() => _LoginCheckerState();
}

class _LoginCheckerState extends State<LoginChecker> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool logged = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return MainPage();
        } else if (snapshot.hasError) {
          return Container(
            child: Text('error'),
          );
        } else {
          return loginButtonScreen();
        }
      },
    );
  }

  loginUser() async {
    print('loginUser');
    await signInWithGoogle().then((value) {
      print(value!.user!.displayName);
      if (value == null) {
        throw Exception('login 정보가 없습니다.');
      } else {
        setState(() {
          logged = true;
        });
      }
    });
  }

  //Main page view
  loginButtonScreen() {
    return Scaffold(
        backgroundColor: myBackgroundColor,
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(),
            SizedBox(
              height: 150,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              //padding: const EdgeInsets.all(80),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                shape: BoxShape.circle,
              ),
              child: Center(child: Image.asset('assets/images/plogo.png')),
            ),
            Spacer(),
            loginButton('Google 로그인', MediaQuery.of(context).size.width * 0.8, Colors.white,
                Colors.grey[600]),
            SizedBox(
              height: 100,
            ),
// loginButton(
//     '카카오 로그인', MediaQuery.of(context).size.width * 0.8, Colors.yellow, Colors.black),
          ],
        ));
  }

  Future<UserCredential?> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = new GoogleSignIn();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      //return await FirebaseAuth.instance.signInWithCredential(credential);
      return await _auth.signInWithCredential(credential);
    }
  }

  void initializeFlutterFire() async {
    await Firebase.initializeApp();
  }

  Widget loginButton(String vendor, double _deviceWidth, Color? color, Color? textColor) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: GestureDetector(
          onTap: () {
            if (vendor == 'Google 로그인') {
              loginUser();
            } else if (vendor == '카카오 로그인') {
              print('kakao login');
            } else {
              throw Exception('로그인 에러');
            }
          },
          child: Card(
            color: color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 3,
            child: Container(
                height: 50,
                width: _deviceWidth * 0.90,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: vendor == 'Google 로그인'
                              ? SvgPicture.asset('assets/images/googlelogo.svg')
                              : Image.asset(
                                  'assets/images/kakaologo.png',
                                  height: 30,
                                )),
                    ),
                    Align(
                      child: Text(
                        '$vendor',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                      alignment: Alignment.center,
                    )
                  ],
                )),
          ),
        ));
  }
}
