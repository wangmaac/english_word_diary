import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englishbookworddiary/pages/bookviewpage.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:englishbookworddiary/widgets/circleimage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchTextController = new TextEditingController();

    List<Map<String, dynamic>> tmpList = [
      {'genre': 'Horror', 'count': 2},
      {'genre': 'Comic', 'count': 12},
      {'genre': 'Romance', 'count': 21},
      {'genre': 'Novel', 'count': 25},
      {'genre': 'PictureBook', 'count': 20},
    ];

    var tmp = 1;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white12,
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleWidget(),
              SizedBox(
                height: 10,
              ),
              friendListWidget(tmp),
              //searchBar(context),
              Spacer(),
              Text(
                'Book Category',
                style: kMainTextPTSans.copyWith(
                    fontSize: 15,
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 5,
              ),
              bookCategoryWidget(context, tmpList),
              Spacer(),
              Text(
                'New Books',
                style: kMainTextPTSans.copyWith(
                    fontSize: 15,
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 5,
              ),
              newBookWidget(context, tmpList),
              Spacer(),
            ],
          ),
        ));
  }

  Widget titleWidget() {
    return RichText(
      text: TextSpan(
          style: kMainTextPTSans.copyWith(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 25),
          text: 'Find New\n',
          children: [
            TextSpan(
              style: kMainTextPTSans.copyWith(color: Colors.grey, fontSize: 20),
              text: 'English Picture Book',
            )
          ]),
    );
  }

  Widget bookCategoryWidget(BuildContext context, List tmpList) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.4,
      width: MediaQuery.of(context).size.width * 0.9,
      child: GridView.count(
        scrollDirection: Axis.horizontal, //스크롤 방향 조절
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        childAspectRatio: 4 / 9,
        mainAxisSpacing: 5,
        children: List.generate(tmpList.length, (index) {
          return Card(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              Container(
                width: 40,
                child: Icon(Icons.person_outline),
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.withOpacity(0.2),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${tmpList[index]['genre']}',
                    style: kMainTextPTSans.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Total of ${tmpList[index]['count']}',
                    style: kMainTextYanolza.copyWith(color: Colors.grey),
                  ),
                ],
              )
            ],
          ));
        }),
      ),
    );
  }

  Widget newBookWidget(BuildContext context, List tmpList) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.55,
      width: MediaQuery.of(context).size.width * 0.9,
      child: GridView.count(
        scrollDirection: Axis.horizontal, //스크롤 방향 조절
        crossAxisCount: 1,
        crossAxisSpacing: 5,
        childAspectRatio: 5 / 4,
        mainAxisSpacing: 5,
        children: List.generate(tmpList.length, (index) {
          return GestureDetector(
            onTap: () {
              QueryDocumentSnapshot aa;
              // Get.to(() => BookViewPage(
              //       document: {'title': 'title', 'content': 'content'} as QueryDocumentSnapshot,
              //     ));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15), topRight: Radius.circular(15))),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Flexible(
                    flex: 6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                      child: Image.network(
                        'http://files.picturebookmakers.com/images/posts/20150607-benji-davies/x2/7.jpg',
                        //'https://assets.bigcartel.com/product_images/216491836/Song+Picturebook.jpg?auto=format&fit=max&w=1500',
                      ),
                    )),
                Flexible(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pencil with me',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              kMainTextPTSans.copyWith(fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        Text(
                          'word count : 10',
                          overflow: TextOverflow.ellipsis,
                          style: kMainTextPTSans.copyWith(color: Colors.grey, fontSize: 12),
                        ),
                        Row()
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          );
        }),
      ),
    );
  }

  Widget friendListWidget(var tmp) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: tmp > 0
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleImageWidget(
                        'https://i.pinimg.com/originals/75/b3/30/75b330c07b9f48b4e007016a02da6723.jpg',
                        45.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleImageWidget(
                        'https://mblogthumb-phinf.pstatic.net/MjAxOTA4MTdfMTkz/MDAxNTY2MDA3ODMwMDE0.1KTuMlwZ4Dil11lmiyTSWw6RN9JVZ0KMO67GGdKuO9cg.1jk6Mzs4PeV9agOAs1oWnYVYXabs1udi0Xvmc9fBX64g.JPEG.yamasa_studio/%EC%95%BC%ED%83%91%EC%97%AD%EC%82%AC%EC%A7%84%EA%B4%80%EC%95%BC%ED%83%91%EC%82%AC%EC%A7%84%EA%B4%80%EC%A6%9D%EB%AA%85%EC%82%AC%EC%A7%840170.jpg?type=w800',
                        45.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleImageWidget(
                        'https://dispatch.cdnser.be/wp-content/uploads/2017/02/be247503d597fc4b0c5c814ffd68a534.jpg',
                        45.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleImageWidget(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFdMDSzj6DDIhPQQGcT1RYPtwk67Wi0BFtjw&usqp=CAU',
                        45.0),
                  ),
                ],
              )
            : Container(
                height: 45,
              ));
  }
}
