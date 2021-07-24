import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englishbookworddiary/models/myword.dart';
import 'package:englishbookworddiary/pages/bookviewpage.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:englishbookworddiary/widgets/circleimage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = new GoogleSignIn();

    CollectionReference<Map<String, dynamic>> mainCollection =
        FirebaseFirestore.instance.collection('Books');

    Stream<QuerySnapshot> currentStream =
        mainCollection.where('owner', isEqualTo: _auth.currentUser!.email.toString()).snapshots();

    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
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
                      await _googleSignIn.signOut();
                      await _auth.signOut();
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
        Flexible(
          flex: 1,
          child: StreamBuilder(
            stream: currentStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Center(child: Text('Error:${snapshot.error}'));
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  return allMyBookWidget(context, snapshot.data!.docs);
              }
            },
          ),
        ),
        //Flexible(flex: 1, child: allMyBookWidget(context, tmpList)),
      ],
    );
  }

  Widget allMyBookWidget(BuildContext context, List<QueryDocumentSnapshot> tmpList) {
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      scrollDirection: Axis.vertical, //스크롤 방향 조절
      crossAxisCount: 4,
      childAspectRatio: 1 / 1,
      children: List.generate(tmpList.length, (index) {
        return GestureDetector(
          onTap: () {
            List<MyWord> wordList = [];
            Stream<QuerySnapshot> tt = tmpList[index].reference.collection('Words').snapshots();
            tt.listen((event) {
              for (var doc in event.docs) {
                MyWord a = MyWord.fromJson(doc.data() as Map<String, dynamic>);
                wordList.add(a);
              }
              Get.to(
                () => BookViewPage(
                  document: tmpList[index],
                  tag: index,
                  wordList: wordList,
                  liked: true,
                ),
              );
            });
          },
          child: Hero(
            tag: 'tag$index',
            child: Container(
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  tmpList[index]['imageURL'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
