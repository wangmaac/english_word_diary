import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englishbookworddiary/models/accountuser.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:englishbookworddiary/widgets/circleimage.dart';
import 'package:englishbookworddiary/widgets/newbooklistwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController? _searchTextController;

  @override
  void initState() {
    _searchTextController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> tmpList = [
      {'genre': 'Horror', 'count': 2},
      {'genre': 'Comic', 'count': 12},
      {'genre': 'Romance', 'count': 21},
      {'genre': 'Novel', 'count': 25},
      {'genre': 'PictureBook', 'count': 20},
    ];

    const iconURL = 'assets/icons/';
    List<String> iconURLList = [
      '${iconURL}horror.png',
      '${iconURL}comic.png',
      '${iconURL}romance.png',
      '${iconURL}novel1.png',
      '${iconURL}picturebook.png',
    ];

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
              friendListWidget(),
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
              Container(child: bookCategoryWidget(context, tmpList, iconURLList)),
              Spacer(),
              Text(
                'New Books List',
                style: kMainTextPTSans.copyWith(
                    fontSize: 15,
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 5,
              ),
              MyBookListWidget(),
              SizedBox(
                height: 5,
              ),
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

  Widget bookCategoryWidget(BuildContext context, List tmpList, List iconListURL) {
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
                child: Image.asset('${iconListURL[index]}'),
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

  Widget friendListWidget() {
    return FutureBuilder(
        future: loadingTopRateUserList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: 75,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(snapshot.data.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircleImageWidget(snapshot.data[index]['userURL'].toString(), 75.0),
                      );
                    })),
              ),
            );
          } else {
            return Center(child: CupertinoActivityIndicator());
          }
        });
  }

  Future loadingTopRateUserList() async {
    List<AccountUser> myAccountList = [];
    List<Map<String, dynamic>> myCountList = [];

    await FirebaseFirestore.instance.collection('Users').get().then((value) {
      myAccountList = value.docs.map((e) => AccountUser.fromJson(e.data())).toList();
    });

    for (var account in myAccountList) {
      await FirebaseFirestore.instance
          .collection('Books')
          .where('uid', isEqualTo: account.uid)
          .get()
          .then((value) {
        myCountList.add({'user': account.uid, 'count': value.size, 'userURL': account.accountURL});
      });
    }
    myCountList.sort((b, a) => a['count'].toString().compareTo(b['count'].toString()));
    return myCountList;
  }
}
