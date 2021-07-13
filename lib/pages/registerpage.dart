import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englishbookworddiary/models/myword.dart';
import 'package:englishbookworddiary/pages/dictionarypage.dart';
import 'package:englishbookworddiary/pages/searchkakaobookpage.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with SingleTickerProviderStateMixin {
  late ImagePicker _picker;
  PickedFile? _image;

  List<MyWord> myWordList = [];

  TextEditingController? _controller;
  // AnimationController? _animationController;

  late FirebaseFirestore ffs;
  FirebaseAuth _auth = FirebaseAuth.instance;

  String owlBotToken = '8fedea05f34418c8334574c1ce851eb40515a819';
  String owlBotURL = 'https://owlbot.info/api/v4/dictionary/';

  late String _selectDropdownValue;

  Future? tmpFuture;

  @override
  void initState() {
    _controller = new TextEditingController();
    // _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    ffs = FirebaseFirestore.instance;
    _picker = ImagePicker();
    _selectDropdownValue = myDropdownTitle[0];
    super.initState();
  }

  @override
  void dispose() {
    // _animationController!.dispose();
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController!);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(88, 65, 148, 1),
          child: Image.asset(
            'assets/images/addword.png',
            fit: BoxFit.cover,
          ),
          onPressed: () async {
            var result = await Get.to(() => DictionaryPage());
            if (myWordList.length == 0) {
              myWordList = result;
            } else {
              result.forEach((e) {
                myWordList = myWordList.where((myWord) => myWord != e).toList();
                setState(() {
                  myWordList.add(e);
                });
              });
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(223, 239, 234, 1),
          actions: [
            FutureBuilder(
              future: tmpFuture,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: CircularProgressIndicator(),
                    width: 30,
                  );
                } else {
                  return IconButton(
                    onPressed: () async {
                      // _animationController!.forward().then((value) {
                      if (verifyingIntegrity()) {
                        File uploadImage = File(_image!.path);

                        DateFormat df = DateFormat('yyyyMMddHHmmss');
                        CollectionReference books = ffs.collection('Books');
                        String docId = '${_auth.currentUser!.uid}${df.format(DateTime.now())}book';
                        DocumentReference myDoc = books.doc('docId');

                        setState(() {
                          tmpFuture = uploadFile(uploadImage);
                        });

                        tmpFuture!.then((imageURL) {
                          if (imageURL != null) {
                            books.doc(docId).set({
                              'title': _controller!.text,
                              'category': _selectDropdownValue,
                              'imageURL': imageURL,
                              'owner': _auth.currentUser!.email.toString(),
                              'dttm': df.format(DateTime.now()).toString()
                            });
                          }
                        });
                      }
                      // _animationController!.reset();
                      //});
                    },
                    icon:
                        // RotationTransition(
                        //   turns: _animation,
                        //   child:
                        Icon(
                      Icons.save,
                      color: Color.fromRGBO(88, 65, 148, 1).withOpacity(0.8),
                    ),
                    // )
                  );
                }
              },
            )
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
                        imageDialog(context);
                      },
                    )))
                : GestureDetector(
                    onTap: () {
                      imageDialog(context);
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    height: 40,
                    child: Row(
//                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            textAlignVertical: TextAlignVertical.center,
                            style:
                                kMainTextPTSans.copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                            onSubmitted: (value) {},
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              hintText: 'Title',
                              hintStyle: kMainTextPTSans.copyWith(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w700,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 120,
                          height: 40,
                          child: DropdownButton(
                            underline: Container(),
                            style: kMainTextYanolza.copyWith(color: Colors.grey, fontSize: 15),
                            onChanged: (value) {
                              setState(() {
                                _selectDropdownValue = value as String;
                              });
                            },
                            items: myDropdownTitle.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            value: _selectDropdownValue,
                          ),
                        )
                      ],
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
                            child: ListTile(
                                onLongPress: () {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext dialogContext) {
                                      return AlertDialog(
                                        content: Text('${myWordList[index].title}을 삭제하시겠어요?'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('취소'),
                                            onPressed: () {
                                              Navigator.of(dialogContext)
                                                  .pop(); // Dismiss alert dialog
                                            },
                                          ),
                                          TextButton(
                                            child: Text('삭제'),
                                            onPressed: () {
                                              setState(() {
                                                myWordList.removeAt(index);
                                              });
                                              Navigator.of(dialogContext)
                                                  .pop(); // Dismiss alert dialog
                                            },
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                title:
                                    Text('${myWordList[index].title} (${myWordList[index].type})')),
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

  Future<void> imageDialog(context) async {
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
                  leading: Image.asset(
                    'assets/images/gall.png',
                    width: 25,
                  ),
                  //Icon(Icons.image),
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
                  leading: Image.asset(
                    'assets/images/kakaobook.png',
                    width: 25,
                  ),
                  // Icon(Icons.language_rounded),
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

  Future<String> uploadFile(File _imageFile) async {
    var storageReference =
        FirebaseStorage.instance.ref().child('books_image/${basename(_imageFile.path)}');
    UploadTask uploadTask = storageReference.putFile(_imageFile);

    await uploadTask;

    Future<String> aa = storageReference.getDownloadURL();

    String ab = '';
    await aa.then((value) {
      ab = value;
    });

    print('ab:$ab');

    return ab;
  }

  bool verifyingIntegrity() {
    bool checker = true;
    if (_controller!.text.trim().length == 0 || _image == null) checker = false;
    return checker;
  }
}
