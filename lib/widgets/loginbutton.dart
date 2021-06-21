import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget loginButton(String vendor, double _deviceWidth, Color? color, Color? textColor) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {},
        child: Card(
          color: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 3,
          child: Container(
              height: 50,
              width: _deviceWidth * 0.90,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: vendor == 'Google 로그인'
                            ? SvgPicture.asset('assets/images/googlelogo.svg')
                            : Image.asset(
                                'assets/images/kakaologo.png',
                                height: 30,
                              )),
                  ),
                  Align(
                    child: Text(
                      '$vendor',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    ),
                    alignment: Alignment.center,
                  )
                ],
              )),
        ),
      ));
}
