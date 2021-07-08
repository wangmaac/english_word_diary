import 'package:englishbookworddiary/pages/firstpage.dart';
import 'package:englishbookworddiary/pages/mybookpage.dart';
import 'package:englishbookworddiary/pages/profilepage.dart';
import 'package:englishbookworddiary/pages/searchpage.dart';
import 'package:englishbookworddiary/widgets/circleimage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late FirebaseAuth _auth;

  @override
  Widget build(BuildContext context) {
    _auth = FirebaseAuth.instance;

    List<Widget> pages = [
      FirstPage(),
      SearchPage(),
      MyBookPage(),
      ProfilePage(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: myLoginInfoAppbar(),
      body: pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        items: [
          SalomonBottomBarItem(
              icon: Icon(Icons.home), title: Text('Home'), selectedColor: Colors.blueGrey),
          SalomonBottomBarItem(
              icon: Icon(Icons.search), title: Text('Search'), selectedColor: Colors.indigo),
          SalomonBottomBarItem(
              icon: Icon(Icons.local_library_outlined),
              title: Text('MyBook'),
              selectedColor: Colors.pink),
          SalomonBottomBarItem(
              icon: Icon(Icons.wb_incandescent_outlined),
              title: Text('Profile'),
              selectedColor: Colors.blue),
        ],
        currentIndex: _currentIndex,
        onTap: (page) {
          setState(() {
            _currentIndex = page;
          });
        },
      ),
    );
  }

  PreferredSizeWidget myLoginInfoAppbar() {
    return PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
//              color: Colors.blueGrey,
            ),
            height: 130,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.notifications_none,
                    color: Colors.grey.shade400,
                    size: 25,
                  ),
                  Spacer(),
                  CircleImageWidget(_auth.currentUser!.photoURL.toString(), 30.0),
                  // SizedBox(
                  //   width: 15,
                  // ),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       '${_auth.currentUser!.email.toString()}',
                  //       style: kMainTextPTSans.copyWith(fontSize: 12),
                  //     ),
                  //     Text(
                  //       '${_auth.currentUser!.displayName.toString()}',
                  //       style: kMainTextYanolza.copyWith(fontSize: 15),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ));
  }
}
