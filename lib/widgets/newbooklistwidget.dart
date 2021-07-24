import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englishbookworddiary/models/bookmodel.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyBookListWidget extends StatefulWidget {
  const MyBookListWidget({Key? key}) : super(key: key);

  @override
  _MyBookListWidgetState createState() => _MyBookListWidgetState();
}

class _MyBookListWidgetState extends State<MyBookListWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<List<BookModel>> snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: () {
                print('asdfasfd');
              },
              child: Container(
                height: MediaQuery.of(context).size.width * 0.55,
                width: MediaQuery.of(context).size.width * 0.9,
                child: GridView.count(
                  scrollDirection: Axis.horizontal, //스크롤 방향 조절
                  crossAxisCount: 1,
                  crossAxisSpacing: 5,
                  childAspectRatio: 5 / 4,
                  mainAxisSpacing: 5,
                  children: List.generate(snapshot.data!.length, (index) {
                    return newBookContentWidget(snapshot.data![index]);
                  }),
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return throw ('${snapshot.error.toString()}');
          }
          return Expanded(
            child: Container(),
          );
        },
        future: loadingNewBookList());
  }

  newBookContentWidget(BookModel myBook) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                image:
                    DecorationImage(image: NetworkImage('${myBook.imageURL}'), fit: BoxFit.cover),
              ),
            )),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${myBook.title}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: kMainTextPTSans.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                FutureBuilder(
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        '${snapshot.data!.docs.first['displayName']}',
                        style: kMainTextYanolza.copyWith(color: Colors.blueGrey, fontSize: 14),
                      );
                    } else {
                      return Text('loading');
                    }
                  },
                  future: FirebaseFirestore.instance
                      .collection('Users')
                      .where('uid', isEqualTo: myBook.uid)
                      .get(),
                ),
                // Text(
                //   '${myBook.owner}',
                //   overflow: TextOverflow.ellipsis,
                //   style: kMainTextPTSans.copyWith(color: Colors.grey, fontSize: 12),
                // ),
                Row()
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Future<List<BookModel>> loadingNewBookList() async {
    List<BookModel> myList = [];

    await FirebaseFirestore.instance
        .collection('Books')
        .orderBy('dttm', descending: true)
        .limit(10)
        .get()
        .then((value) {
      myList = value.docs.map((e) => BookModel.fromJson(e.data())).toList();
    });

    return myList;
  }
}
