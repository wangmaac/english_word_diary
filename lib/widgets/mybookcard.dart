import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class MyBookCard extends StatelessWidget {
  final DocumentSnapshot document;
  final Stream<QuerySnapshot> myStream;

  const MyBookCard({Key? key, required this.document, required this.myStream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Stack(children: [
              ExpandableNotifier(
                  child: Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  //  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                          child: Text(
                            '${document['title']}',
                            style:
                                kMainTextPTSans.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Center(
                          child: SizedBox(
                              height: 180,
                              child: Image.network(
                                document['imageURL'],
                                fit: BoxFit.contain,
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ScrollOnExpand(
                          // scrollOnExpand: false,
                          // scrollOnCollapse: false,
                          child: ExpandablePanel(
                            theme: const ExpandableThemeData(
                              headerAlignment: ExpandablePanelHeaderAlignment.center,
                              tapBodyToCollapse: true,
                            ),
                            header: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  height: 28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[850],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.remove_red_eye_sharp,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '100',
                                        style: kMainTextYanolza.copyWith(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  //width: 70,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.red[700],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      //TODO 뷰값이 1백만 넘어가면 왕관으로.
                                      Text(
                                        '10',
                                        style: kMainTextYanolza.copyWith(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            collapsed: Container(),
                            expanded: Column(
                              children: List.generate(snapshot.data!.docs.length, (index) {
                                return Card(
                                  child: ListTile(
                                    dense: true,
                                    title: Text(
                                      '${snapshot.data!.docs[index]['title']}',
                                      style: kMainTextPTSans.copyWith(fontWeight: FontWeight.w700),
                                    ),
                                    visualDensity: VisualDensity.standard,
                                    leading: Text('${snapshot.data!.docs[index]['type']}'),
                                    subtitle: Html(
                                      data: snapshot.data!.docs[index]['example'] != null
                                          ? "${snapshot.data!.docs[index]['content']} <br><br><span style='color:indigo;'>ex)${snapshot.data!.docs[index]['example']}</span>"
                                          : "${snapshot.data!.docs[index]['content']}",
                                      shrinkWrap: true,
                                    ),
                                    tileColor: Colors.grey[300],
                                  ),
                                );
                              }),
                            ),
                            builder: (_, collapsed, expanded) {
                              return Padding(
                                padding: EdgeInsets.only(right: 10, bottom: 8),
                                child: Expandable(
                                  collapsed: collapsed,
                                  expanded: expanded,
                                  theme: const ExpandableThemeData(crossFadePoint: 0),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
              //flag
              Padding(
                padding: const EdgeInsets.only(top: 14.0, bottom: 14.0, right: 34.0),
                child: Align(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      '${snapshot.data!.docs.length}',
                      style: kMainTextYanolza.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    height: 60,
                    width: 40,
                    //color: Colors.orange[400],
                  ),
                  alignment: Alignment.topRight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0, bottom: 14.0, right: 34.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: ClipPath(
                    clipper: MyCustomClipper(),
                    child: Container(
                      color: Colors.white,
                      height: 60,
                      width: 40,
                    ),
                  ),
                ),
              )
            ]);
          } else {
            return Container();
          }
        },
        stream: myStream);
    // myStream.listen((event) {
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(size.width / 2, size.height / 1.5)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
