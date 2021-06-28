import 'package:englishbookworddiary/controller/controller.dart';
import 'package:englishbookworddiary/models/user.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
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
      Center(child: Text('memu1')),
      Center(child: Text('memu2')),
      Center(child: Text('memu3')),
      Center(child: Text('memu4')),
    ];
    return Scaffold(
      appBar: PreferredSize(
          //preferredSize: Size.fromHeight(kToolbarHeight),
          preferredSize: Size.fromHeight(130),
          child: SafeArea(
            child: Stack(children: [
              //background
              Container(
                color: Colors.yellow,
                height: 130,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                  color: Colors.blueGrey,
                ),
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            GetController.to.googleUser!.imageURL.toString(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${GetController.to.googleUser!.email.toString()}',
                            style: kMainTextBasic.copyWith(fontSize: 15),
                          ),
                          Text(
                            '${GetController.to.googleUser!.userName.toString()}',
                            style: kMainTextBasic.copyWith(fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]),
          )
          // AppBar(
          //   elevation: 0.0,
          //   backgroundColor: myBackgroundColor,
          //   title: Text(
          //     'title',
          //     style: kMainTextBasic.copyWith(color: Colors.grey),
          //   ),
          // ),
          ),
      body: pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        items: [
          SalomonBottomBarItem(
              icon: Icon(Icons.home), title: Text('menu1'), selectedColor: Colors.blueGrey),
          SalomonBottomBarItem(
              icon: Icon(Icons.home), title: Text('menu2'), selectedColor: Colors.blueGrey),
          SalomonBottomBarItem(
              icon: Icon(Icons.home), title: Text('menu3'), selectedColor: Colors.blueGrey),
          SalomonBottomBarItem(
              icon: Icon(Icons.home), title: Text('menu4'), selectedColor: Colors.blueGrey),
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
}
