import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:englishbookworddiary/widgets/circleimage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn _googleSignIn = new GoogleSignIn();
    FirebaseAuth _auth = FirebaseAuth.instance;

    List<Map<String, dynamic>> tmpList = [
      {'title': 'Sing a song', 'count': 9},
      {'title': 'Fear of stranger', 'count': 39},
      {'title': 'Pet life', 'count': 2},
      {'title': 'Gorilla champ', 'count': 21},
      {'title': 'Dreaming', 'count': 12},
      {'title': 'Sing a song', 'count': 9},
      {'title': 'Fear of stranger', 'count': 39},
      {'title': 'Pet life', 'count': 2},
      {'title': 'Gorilla champ', 'count': 21},
      {'title': 'Dreaming', 'count': 12},
      {'title': 'Dreaming', 'count': 12},
      {'title': 'Sing a song', 'count': 9},
      {'title': 'Fear of stranger', 'count': 39},
    ];

    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            //color: Color.fromRGBO(228, 240, 250, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(),
                Align(
                  child: TextButton(
                    child: Text(
                      '로그아웃',
                      style: kMainTextYanolza.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                    onPressed: () async {
                      // await _googleSignIn.signOut();
                      // await _auth.signOut().whenComplete(() => Get.off(() => FutureSplash()));
                      await _googleSignIn.signOut();
                      await _auth.signOut();
                      //await _googleSignIn.signOut().then((value) => exit(0));
                      //await _googleSignIn.signOut().then((value) => SystemNavigator.pop());
                    },
                  ),
                  alignment: Alignment.centerRight,
                ),
                Spacer(),
                CircleImageWidget(_auth.currentUser!.photoURL, 120.0),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '${_auth.currentUser!.displayName}',
                  style: kMainTextYanolza.copyWith(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${_auth.currentUser!.email}',
                  style: kMainTextYanolza.copyWith(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.pink,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit, color: Colors.white, size: 20),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '1',
                            style: kMainTextPTSans.copyWith(
                                color: Colors.white, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite, color: Colors.white, size: 20),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '13',
                            style: kMainTextPTSans.copyWith(
                                color: Colors.white, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer()
              ],
            ),
          ),
        ),
        Flexible(flex: 1, child: allMyBookWidget(context, tmpList)),
      ],
    );
  }

  Widget allMyBookWidget(BuildContext context, List tmpList) {
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      scrollDirection: Axis.vertical, //스크롤 방향 조절
      crossAxisCount: 4,
      childAspectRatio: 1 / 1,
      children: List.generate(tmpList.length, (index) {
        return Container(
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(8)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'http://files.picturebookmakers.com/images/posts/20150607-benji-davies/x2/7.jpg',
              fit: BoxFit.cover,
            ),
          ),
        );
      }),
    );
  }
}
