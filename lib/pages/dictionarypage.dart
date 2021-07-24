import 'dart:async';
import 'dart:convert';
import 'package:englishbookworddiary/models/dictionary_model.dart';
import 'package:englishbookworddiary/models/myword.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  TextEditingController? _controller;
  // ignore: close_sinks
  StreamController? _streamController;
  Stream? _stream;
  Timer? _debounce;
  List<MyWord> resultList = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool streamStatus = false;

  String owlBotToken = '8fedea05f34418c8334574c1ce851eb40515a819';
  String owlBotURL = 'https://owlbot.info/api/v4/dictionary/';

  @override
  void initState() {
    _controller = new TextEditingController();
    _streamController = new StreamController();
    _stream = _streamController!.stream;
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.back(result: resultList);
              },
            ),
            centerTitle: true,
            backgroundColor: Color.fromRGBO(223, 239, 234, 1),
            title: Text('Dictionary',
                style:
                    kMainTextYanolza.copyWith(fontSize: 20, color: Color.fromRGBO(88, 65, 148, 1))),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(24.0)),
                      child: TextFormField(
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]"))],
                        onFieldSubmitted: (value) {
                          _search(_controller!.text);
                        },
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) _debounce!.cancel();
                          _debounce = Timer(const Duration(seconds: 1), () {
                            _search(_controller!.text);
                          });
                        },
                        style: kMainTextPTSans,
                        controller: _controller,
                        decoration: InputDecoration(
                            hintStyle: kMainTextPTSans,
                            hintText: 'Search for a word',
                            contentPadding: const EdgeInsets.only(left: 20.0, right: 20.0),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _search(_controller!.text);
                    },
                    icon: Icon(
                      Icons.search_outlined,
                      color: Color.fromRGBO(48, 179, 158, 1),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: Container(
            child: StreamBuilder(
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  if (streamStatus) {
                    return Center(child: Text('Sorry, Nothing your word'));
                  } else {
                    return Center(child: Text('Enter a search word'));
                  }
                }
                if (snapshot.data == 'waiting') {
                  return CircularProgressIndicator();
                }
                return ListView.builder(
                    //itemCount: snapshot.data['definitions'].length,
                    itemCount: snapshot.data.definitions.length,
                    itemBuilder: (context, index) {
                      return ListBody(
                        children: [
                          Container(
                            color: Colors.grey[300],
                            child: ListTile(
                                onTap: () {
                                  rebuildWordList(
                                      snapshot.data.word, snapshot.data.definitions[index]);
                                },
                                leading: snapshot.data.definitions[index].imageUrl == null
                                    ? null
                                    : CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(snapshot.data.definitions[index].imageUrl),
                                      ),
                                title: snapshot.data.definitions[index].type == null
                                    ? Text(_controller!.text.trim())
                                    : Text(_controller!.text.trim() +
                                        '(' +
                                        snapshot.data.definitions[index].type +
                                        ')')),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(snapshot.data.definitions[index].definition),
                          ),
                          snapshot.data.definitions[index].example == null
                              ? Text('')
                              : Html(
                                  data: "<span style='color:grey;'>ex) " +
                                      snapshot.data.definitions[index].example +
                                      "</span>",
                                  shrinkWrap: true,
                                ),
                        ],
                      );
                    });
              },
              stream: _stream,
            ),
          )),
    );
  }

  Future _search(String keyWord) async {
    if (_controller?.text == null || _controller!.text.length == 0) {
      _streamController!.add(null);
      streamStatus = false;

      return;
    }

    streamStatus = true;

    Uri url = Uri.parse(owlBotURL + keyWord.trim());

    final response = await http.get(
      url,
      headers: {'Authorization': 'Token ' + owlBotToken},
    );

    if (json.decode(response.body) is Map) {
      DictionaryModel dm = DictionaryModel.fromJson(json.decode(response.body));
      _streamController!.add(dm);
    } else {
      _streamController!.add(null);
    }
  }

  void rebuildWordList(String title, Definitions content) {
    MyWord mw = new MyWord(
        title: title, type: content.type, meaning: content.definition, example: content.example);

    if (resultList.length == 0) {
      resultList.add(mw);
    } else {
      resultList = resultList.where((myWord) => myWord != mw).toList();
      resultList.add(mw);
    }
    showSnackBar();
  }

  showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'completed adding words.',
        style: kMainTextPTSans,
      ),
      duration: Duration(milliseconds: 1000),
    ));
  }
}
