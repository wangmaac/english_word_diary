import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englishbookworddiary/pages/registerpage.dart';
import 'package:englishbookworddiary/widgets/mybookcard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBookPage extends StatefulWidget {
  const MyBookPage({Key? key}) : super(key: key);

  @override
  _MyBookPageState createState() => _MyBookPageState();
}

class _MyBookPageState extends State<MyBookPage> {
  late Stream<QuerySnapshot> currentStream;
  late CollectionReference mainCollection;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    mainCollection = FirebaseFirestore.instance.collection('Books');

    currentStream = mainCollection
        .where('owner', isEqualTo: _auth.currentUser!.email)
        .orderBy(FieldPath.documentId, descending: true)
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: GestureDetector(
          onTap: () {
            Get.to(() => RegisterPage());
          },
          child: Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            width: 60,
            height: 60,
            child: Icon(
              Icons.add_circle_outline,
              size: 60,
            ),
          ),
        ),
        body: StreamBuilder(
          stream: currentStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            int bookCount = 0;
            if (snapshot.hasError) return Center(child: Text('Error:${snapshot.error}'));
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                bookCount = snapshot.data!.docs.length;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final DocumentSnapshot document = snapshot.data!.docs[index];
                    var current2 = document.reference.collection('Words').snapshots();
                    return MyBookCard(document: document, myStream: current2);
                  },
                  itemCount: bookCount,
                  //physics: const BouncingScrollPhysics(),
                );
            }
          },
        ));
  }
}
