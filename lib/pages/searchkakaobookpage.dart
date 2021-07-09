import 'dart:io';
import 'package:englishbookworddiary/controller/controller.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:englishbookworddiary/widgets/searchbarbooktitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SearchKAKAOBookPage extends StatelessWidget {
  const SearchKAKAOBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GetController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text(
          '카카오북 검색',
          style: kMainTextYanolza.copyWith(fontSize: 30),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SearchBarBookTitle(),
          ),
          GetBuilder<GetController>(
            init: GetController(),
            builder: (controller) {
              if (GetController.to.kakaoBookList.length == 0) {
                return Container();
              } else {
                return Expanded(
                  child: GridView.count(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    scrollDirection: Axis.vertical, //스크롤 방향 조절
                    crossAxisCount: 4,
                    childAspectRatio: 1 / 1,
                    children: List.generate(GetController.to.kakaoBookList.length, (index) {
                      return GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(8)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              GetController.to.kakaoBookList[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        onTap: () async {
                          _fileFromImageURL(GetController.to.kakaoBookList[index])
                              .then((value) => Get.back(result: value));
                        },
                      );
                    }),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Future<File> _fileFromImageURL(String url) async {
    DateFormat df = DateFormat('yyyyMMddHHmmss');

    var uri = Uri.parse(url);
    final response = await http.get(uri);
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File(join(documentDirectory.path, '${df.format(DateTime.now())}.jpg'));
    file.writeAsBytesSync(response.bodyBytes);
    return file;
  }
}
