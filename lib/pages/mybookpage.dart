import 'package:englishbookworddiary/pages/registerpage.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:englishbookworddiary/widgets/circleimage.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
const imageUrl = 'http://files.picturebookmakers.com/images/posts/20150607-benji-davies/x2/7.jpg';
const imageUrl2 =
    'https://mblogthumb-phinf.pstatic.net/MjAxOTA4MTdfMTkz/MDAxNTY2MDA3ODMwMDE0.1KTuMlwZ4Dil11lmiyTSWw6RN9JVZ0KMO67GGdKuO9cg.1jk6Mzs4PeV9agOAs1oWnYVYXabs1udi0Xvmc9fBX64g.JPEG.yamasa_studio/%EC%95%BC%ED%83%91%EC%97%AD%EC%82%AC%EC%A7%84%EA%B4%80%EC%95%BC%ED%83%91%EC%82%AC%EC%A7%84%EA%B4%80%EC%A6%9D%EB%AA%85%EC%82%AC%EC%A7%840170.jpg?type=w800';
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

class MyBookPage extends StatelessWidget {
  const MyBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
            ),
            shape: BoxShape.circle),
        width: 50,
        height: 50,
        //color: Colors.black,
        child: RawMaterialButton(
          elevation: 0.0,
          fillColor: Colors.yellow,
          child: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          shape: CircleBorder(),
          onPressed: () {
            Get.to(() => RegisterPage());
          },
        ),
      ),
      body: myBookListWidget(context, tmpList),
    );
  }

  Widget myBookListWidget(BuildContext context, List tmpList) {
    return ListView(
        physics: const BouncingScrollPhysics(),
        children: List.generate(tmpList.length, (index) {
          return MyBookCard();
        })

        // <Widget>[MyBookCard()],
        );
  }
}

class MyBookCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            SizedBox(
                height: 250,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                )),
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '조회 10, 좋아 10',
                      style: kMainTextYanolza.copyWith(fontSize: 18),
                    )),
                collapsed: ListTile(
                  title: Text('title'),
                  visualDensity: VisualDensity.standard,
                  trailing: Text('trailing'),
                  leading: Text('leading'),
                  subtitle: Text('subtitle'),
                ),
                // Text(
                //   loremIpsum,
                //   softWrap: false,
                //   maxLines: 2,
                //   overflow: TextOverflow.ellipsis,
                // ),
                expanded: Column(
                  children: List.generate(5, (index) {
                    return Card(
                      child: ListTile(
                        title: Text('title'),
                        visualDensity: VisualDensity.standard,
                        trailing: Text('trailing'),
                        leading: Text('leading'),
                        subtitle: Text('subtitle'),
                        tileColor: Colors.grey,
                      ),
                    );
                  }),
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
    ));
  }
}
