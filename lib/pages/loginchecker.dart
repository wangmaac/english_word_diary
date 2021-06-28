import 'package:englishbookworddiary/controller/controller.dart';
import 'package:englishbookworddiary/models/user.dart';
import 'package:englishbookworddiary/pages/mainpage.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginChecker extends StatefulWidget {
  const LoginChecker({Key? key}) : super(key: key);

  @override
  _LoginCheckerState createState() => _LoginCheckerState();
}

class _LoginCheckerState extends State<LoginChecker> {
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;
  MyUser? myUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    FirebaseAuth.instance.signOut();
    logoutUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (!snapshot.hasData) {
          print('!snapshot.hasData');
          return loginButtonScreen();
        } else {
          print('snapshot.hasData');
          myUser = new MyUser(
              uid: snapshot.data!.uid,
              email: snapshot.data!.email.toString(),
              userName: snapshot.data!.displayName,
              imageURL: snapshot.data!.photoURL);
          return MainPage(myUser!);
        }
      },
    );
  }

  loginUser() {
    signInWithGoogle().then((value) {
      if (value != null) {
        myUser = new MyUser(
            uid: value.user!.uid,
            email: value.user!.email.toString(),
            userName: value.user!.displayName,
            imageURL: value.user!.photoURL);
        //GetController.to.setGoogleUser(createMyUser2(value.user));
      } else {
        throw Exception('login 정보가 없습니다.');
      }
    });
  }

  logoutUser() {
    FirebaseAuth.instance.signOut();
    _googleSignIn.signOut();
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

  MyUser createMyUser2(dynamic user) {
    return new MyUser(
        uid: user.uid, email: user.email, userName: user.displayName, imageURL: user.photoURL);
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
