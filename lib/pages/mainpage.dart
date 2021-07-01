import 'package:englishbookworddiary/controller/controller.dart';
import 'package:englishbookworddiary/models/user.dart';
import 'package:englishbookworddiary/pages/firstpage.dart';
import 'package:englishbookworddiary/pages/searchpage.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:englishbookworddiary/widgets/circleimage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainPage extends StatefulWidget {
  final MyUser loginInfo;

  const MainPage(this.loginInfo, {Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Get.put(GetController());
    GetController.to.setGoogleUser(widget.loginInfo);

    List<Widget> pages = [
      FirstPage(),
      SearchPage(),
      Center(child: Text('memu3')),
      Center(child: Text('memu4')),
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
                  CircleImageWidget(GetController.to.googleUser!.imageURL.toString(), 35.0),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${GetController.to.googleUser!.email.toString()}',
                        style: kMainTextPTSans.copyWith(fontSize: 12),
                      ),
                      Text(
                        '${GetController.to.googleUser!.userName.toString()}',
                        style: kMainTextYanolza.copyWith(fontSize: 15),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
