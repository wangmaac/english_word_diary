import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:englishbookworddiary/models/dictionary_model.dart';
import 'package:englishbookworddiary/models/myword.dart';
import 'package:englishbookworddiary/pages/dictionarypage.dart';
import 'package:englishbookworddiary/pages/searchkakaobookpage.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late ImagePicker _picker;
  PickedFile? _image;

  List<MyWord> myWordList = [];

  TextEditingController? _controller;
  StreamController? _streamController;
  Stream? _stream;

  String owlBotToken = '8fedea05f34418c8334574c1ce851eb40515a819';
  String owlBotURL = 'https://owlbot.info/api/v4/dictionary/';

  @override
  void initState() {
    _controller = new TextEditingController();
    _streamController = new StreamController();
    _stream = _streamController!.stream;
    _picker = ImagePicker();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(88, 65, 148, 1),
          child: Icon(
            Icons.add,
            color: Color.fromRGBO(223, 239, 234, 1),
          ),
          onPressed: () async {
            var result = await Get.to(() => DictionaryPage());
            print(result.length);
            setState(() {
              myWordList.addAll(result..removeWhere((e) => myWordList.contains(e)));
              // resultList = [...myWordList, ...result];
              // myWordList = result;
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(223, 239, 234, 1),
          actions: [
            IconButton(
                onPressed: () {
                  ///TODO store to db
                },
                icon: Icon(
                  Icons.save,
                  color: Color.fromRGBO(88, 65, 148, 1).withOpacity(0.7),
                ))
          ],
          title: Text('Picture Book',
              style:
                  kMainTextYanolza.copyWith(fontSize: 20, color: Color.fromRGBO(88, 65, 148, 1))),
        ),
        body: Column(
          children: [
            _image == null
                ? Container(
                    height: 250,
                    child: Center(
                        child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1.5, color: Colors.grey)),
                        height: 100,
                        width: 100,
                        child: Icon(
                          Icons.camera_alt,
                          size: 40,
                        ),
                      ),
                      onTap: () {
                        imageDialog();
                      },
                    )))
                : GestureDetector(
                    onTap: () {
                      imageDialog();
                    },
                    child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: Image.file(
                          File(_image!.path.toString()),
                          fit: BoxFit.contain,
                        )),
                  ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  TextField(
                    textAlignVertical: TextAlignVertical.center,
                    style: kMainTextPTSans.copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                    onSubmitted: (value) {},
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      hintText: 'Title',
                      hintStyle: kMainTextPTSans.copyWith(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w700,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Expanded(
                      child: ListView(
                    children: List.generate(myWordList.length, (index) {
                      return ListBody(
                        children: [
                          Container(
                            color: Colors.grey[300],
                            child:
                                ListTile(onTap: () {}, title: Text('${myWordList[index].title}')),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${myWordList[index].meaning}'),
                          ),
                        ],
                        //resultList[index].title
                      );
                    }),
                  ))
                ],
              ),
            ),
          ],
        ));
  }

  Future _getImage() async {
    PickedFile? image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future<void> imageDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(8),
            //title: Text('title'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: ListTile(
                  leading: Icon(Icons.image),
                  //  tileColor: Colors.blueGrey,
                  visualDensity: VisualDensity.compact,
                  title: Text(
                    '갤러리에서 가져오기',
                    style: kMainTextYanolza,
                  ),
                  dense: true,
                  onTap: () {
                    _getImage();
                    Get.back();
                  },
                )),
                Flexible(
                    child: ListTile(
                  visualDensity: VisualDensity.compact,
                  leading: Icon(Icons.language_rounded),
                  //    tileColor: Colors.indigo,
                  title: Text(
                    'KAKAO에서 책검색 하기',
                    style: kMainTextYanolza,
                  ),
                  dense: true,
                  onTap: () async {
                    Get.back();
                    var value = await Get.to(() => SearchKAKAOBookPage());
                    if (value != null) {
                      setState(() {
                        _image = PickedFile(value.path);
                      });
                    }
                  },
                )),
              ],
            ));
      },
    );
  }

  Future _search(String keyWord) async {
    if (_controller?.text == null || _controller!.text.length == 0) {
      _streamController!.add(null);
    }

    Uri url = Uri.parse(owlBotURL + keyWord.trim());

    final response = await http.get(
      url,
      headers: {'Authorization': 'Token ' + owlBotToken},
    );

    if (json.decode(response.body) is Map) {
      DictionaryModel dm = DictionaryModel.fromJson(json.decode(response.body));
      _streamController!.add(dm);
    }
  }
}
