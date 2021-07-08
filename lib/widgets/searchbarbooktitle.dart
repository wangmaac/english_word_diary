import 'dart:convert';
import 'package:englishbookworddiary/controller/controller.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchBarBookTitle extends StatelessWidget {
  const SearchBarBookTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GetController());
    return Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
        width: MediaQuery.of(context).size.width * 0.9,
        alignment: Alignment.centerLeft,
        height: 50,
        child: TextField(
          style: kMainTextPTSans.copyWith(fontSize: 18, fontWeight: FontWeight.w700),
          onSubmitted: (value) {
            if (value.length > 0) {
              callAPIBookSearch(value).then((value) {
                GetController.to.insertKakaoBookList(value);
              });
            }
          },
          keyboardType: TextInputType.text,
          //onChanged: (text) {},
          decoration: InputDecoration(
              hintText: 'Search Book...',
              hintStyle: kMainTextPTSans.copyWith(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w700,
              ),
              border: InputBorder.none,
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

  callAPIBookSearch(String title) async {
    const kakaoAPIKey = 'ba7266e1cc0be44ed3061c608b01739c';

    var url = Uri.https('dapi.kakao.com', '/v3/search/book', {'target': 'title', 'query': title});

    var response = await http.get(url, headers: {
      'Authorization': 'KakaoAK $kakaoAPIKey',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      List<String> kakaoBookList = [];

      jsonResponse.forEach((key, value) {
        if (key == 'documents') {
          value.forEach((e) {
            if (e['thumbnail'].toString().length != 0) {
              kakaoBookList.add(e['thumbnail'].toString());
            }
          });
        }
      });

      return kakaoBookList;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
