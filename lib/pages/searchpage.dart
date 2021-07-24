import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englishbookworddiary/models/myword.dart';
import 'package:englishbookworddiary/pages/bookviewpage.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // ignore: close_sinks
  Stream<QuerySnapshot>? myStream;
  TextEditingController _controller = new TextEditingController();
  FocusNode _focusNode = new FocusNode();
  String keyWord = '';

  @override
  void initState() {
    myStream = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _searchBar(context),
        SizedBox(
          height: 20,
        ),
        searchBookWidget(context, myStream),
        Row(),
      ],
    ));
  }

  Widget searchBookWidget(BuildContext context, Stream<QuerySnapshot>? stream) {
    return Expanded(
      child: stream == null
          ? Container()
          : StreamBuilder(
              stream: stream,
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
                    if (bookCount > 0) {
                      List<QueryDocumentSnapshot> mySearchList = snapshot.data!.docs
                          .where((doc) => doc['title'].toString().contains('$keyWord'))
                          .toList();
                      return searchBookContentQueryDocumentSnapshot(mySearchList);
                    } else {
                      return Center(
                        child: Text('No Books'),
                      );
                    }

                    return Container();
                }
              }),
    );
  }

  Widget _searchBar(BuildContext context) {
    TextEditingController _controller = new TextEditingController();
    return Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
        width: MediaQuery.of(context).size.width * 0.9,
        alignment: Alignment.centerLeft,
        height: 50,
        child: TextField(
          focusNode: _focusNode,
          controller: _controller,
          style: kMainTextPTSans.copyWith(fontSize: 18, fontWeight: FontWeight.w700),
          onSubmitted: (value) {
            keyWord = value;
            setState(() {
              // myStream = FirebaseFirestore.instance
              //     .collection('Books')
              //     .where('title', isGreaterThan: '$value')
              //     .where('title', isLessThan: '$value' + 'z')
              //     .snapshots();
              myStream = FirebaseFirestore.instance.collection('Books').snapshots();
            });
          },
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              hintText: 'Search Book...',
              hintStyle: kMainTextPTSans.copyWith(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w700,
              ),
              border: InputBorder.none,
              suffixIcon: _focusNode.hasFocus
                  ? IconButton(
                      splashRadius: 1,
                      onPressed: () {
                        setState(() {
                          _controller.text = '';
                        });
//                        showSearch(context: context, delegate: _delegate);
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.grey[300],
                      ),
                      iconSize: 20,
                    )
                  : Container(),
              icon: Padding(
                padding: EdgeInsets.only(left: 13),
                child: Icon(
                  Icons.search,
                  size: 18,
                  color: Colors.black,
                ),
              )),
        ));
  }

  // Widget searchBookContent(AsyncSnapshot<QuerySnapshot> snapshot) {
  //   return GridView.count(
  //     padding: const EdgeInsets.symmetric(horizontal: 18),
  //     scrollDirection: Axis.vertical, //스크롤 방향 조절
  //     crossAxisCount: 2,
  //     crossAxisSpacing: 5,
  //     childAspectRatio: 4 / 5,
  //     mainAxisSpacing: 5,
  //     children: List.generate(snapshot.data!.docs.length, (index) {
  //       Future<QuerySnapshot> myFuture =
  //           snapshot.data!.docs[index].reference.collection('Words').get();
  //       return GestureDetector(
  //         onTap: () {
  //           final Stream<QuerySnapshot> parameterStream =
  //               snapshot.data!.docs[index].reference.collection('Words').snapshots();
  //
  //           List<MyWord> wordList = [];
  //
  //           parameterStream.listen((event) {
  //             for (var doc in event.docs) {
  //               MyWord a = MyWord.fromJson(doc.data() as Map<String, dynamic>);
  //               wordList.add(a);
  //             }
  //             Get.to(
  //               () => BookViewPage(
  //                 document: snapshot.data!.docs[index],
  //                 tag: index,
  //                 wordList: wordList,
  //                 liked: true,
  //               ),
  //             );
  //           });
  //         },
  //         child: Card(
  //           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
  //             Flexible(
  //                 flex: 6,
  //                 child: ClipRRect(
  //                   child: Image.network(
  //                     '${snapshot.data!.docs[index]['imageURL']}',
  //                     fit: BoxFit.cover,
  //                   ),
  //                 )),
  //             Flexible(
  //               flex: 2,
  //               child: Container(
  //                 padding: const EdgeInsets.only(left: 10, right: 10),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     SizedBox(
  //                       height: 7,
  //                     ),
  //                     Expanded(
  //                       child: Text(
  //                         '${snapshot.data!.docs[index]['title']}',
  //                         maxLines: 1,
  //                         overflow: TextOverflow.ellipsis,
  //                         style:
  //                             kMainTextPTSans.copyWith(fontWeight: FontWeight.w700, fontSize: 15),
  //                       ),
  //                     ),
  //                     Container(
  //                       height: 20,
  //                       child: FutureBuilder(
  //                         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //                           if (snapshot.hasData) {
  //                             return Text(
  //                               'word count : ${snapshot.data!.docs.length}',
  //                               overflow: TextOverflow.ellipsis,
  //                               style: kMainTextPTSans.copyWith(color: Colors.grey, fontSize: 12),
  //                             );
  //                           } else {
  //                             return Container();
  //                           }
  //                         },
  //                         future: myFuture,
  //                       ),
  //                     ),
  //                     Row()
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ]),
  //         ),
  //       );
  //     }),
  //   );
  // }

  Widget searchBookContentQueryDocumentSnapshot(List<QueryDocumentSnapshot> snapshotList) {
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      scrollDirection: Axis.vertical, //스크롤 방향 조절
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      childAspectRatio: 4 / 5,
      mainAxisSpacing: 5,
      children: List.generate(snapshotList.length, (index) {
        Future<QuerySnapshot> myFuture = snapshotList[index].reference.collection('Words').get();

        return GestureDetector(
          onTap: () {
            final Stream<QuerySnapshot> parameterStream =
                snapshotList[index].reference.collection('Words').snapshots();

            List<MyWord> wordList = [];

            parameterStream.listen((event) {
              for (var doc in event.docs) {
                MyWord a = MyWord.fromJson(doc.data() as Map<String, dynamic>);
                wordList.add(a);
              }
              Get.to(
                  () => BookViewPage(
                        document: snapshotList[index],
                        tag: index,
                        wordList: wordList,
                        liked: true,
                      ),
                  transition: Transition.zoom);
            });
          },
          child: Hero(
            tag: 'tag$index',
            child: Card(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Flexible(
                    flex: 4,
                    child: ClipRRect(
                      child: Image.network(
                        '${snapshotList[index]['imageURL']}',
                        fit: BoxFit.cover,
                      ),
                    )),
                Flexible(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 7,
                        ),
                        Expanded(
                          child: Text(
                            '${snapshotList[index]['title']}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                kMainTextPTSans.copyWith(fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${snapshotList[index]['owner']}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: kMainTextPTSans.copyWith(fontSize: 10),
                          ),
                        ),
                        Container(
                          height: 20,
                          child: FutureBuilder(
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  'word count : ${snapshot.data!.docs.length}',
                                  overflow: TextOverflow.ellipsis,
                                  style: kMainTextPTSans.copyWith(color: Colors.grey, fontSize: 12),
                                );
                              } else {
                                return Container();
                              }
                            },
                            future: myFuture,
                          ),
                        ),
                        Row()
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        );
      }),
    );
  }
}
