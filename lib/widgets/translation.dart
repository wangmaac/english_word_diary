// import 'package:dio/dio.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:flutter/material.dart';

class TranslationBar extends StatelessWidget {
  const TranslationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const kakaoAPIKey = 'ba7266e1cc0be44ed3061c608b01739c';
    const url = 'https://dapi.kakao.com/v2/translation/translate';

    return Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
        width: MediaQuery.of(context).size.width * 0.9,
        alignment: Alignment.centerLeft,
        height: 50,
        child: TextField(
          style: kMainTextPTSans.copyWith(fontSize: 18, fontWeight: FontWeight.w700),
          onSubmitted: (value) {
            // callAPI(url, kakaoAPIKey, value);
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

  // Future callAPI(String url, String key, String value) async {
  //   var dio = Dio(BaseOptions(headers: {
  //     'Authorization': 'KakaoAK $key',
  //     'Content-Type': 'application/x-www-form-urlencoded'
  //   }));
  //   final response =
  //       await dio.post(url, data: {'src_lang': 'en', 'target_lang': 'kr', 'query': '$value'});
  //
  //   print(response.data.toString());
  // }
}
