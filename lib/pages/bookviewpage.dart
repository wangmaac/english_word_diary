import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englishbookworddiary/models/myword.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BookViewPage extends StatefulWidget {
  final QueryDocumentSnapshot document;
  final int tag;
  final List<MyWord> wordList;
  final bool liked;

  const BookViewPage(
      {required this.document,
      required this.tag,
      required this.wordList,
      required this.liked,
      Key? key})
      : super(key: key);

  @override
  _BookViewPageState createState() => _BookViewPageState();
}

class _BookViewPageState extends State<BookViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text('${widget.document['title']}'),
      ),
      body: Hero(
        tag: 'tag' + widget.tag.toString(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Image.network(
                  '${widget.document['imageURL']}',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.liked
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(Icons.favorite_border),
                  Text(
                    '좋아용 12회',
                    style: kMainTextYanolza,
                  ),
                  Row()
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Flexible(
                flex: 2,
                child: ListView.builder(
                  itemCount: widget.wordList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        dense: true,
                        title: Text(
                          '${widget.wordList[index].title}',
                          style: kMainTextPTSans.copyWith(fontWeight: FontWeight.w700),
                        ),
                        visualDensity: VisualDensity.standard,
                        leading: Text('${widget.wordList[index].type}'),
                        subtitle: Html(
                          data: widget.wordList[index].example != null
                              ? "${widget.wordList[index].meaning} <br><br><span style='color:indigo;'>ex)${widget.wordList[index].example}</span>"
                              : "${widget.wordList[index].meaning}",
                          shrinkWrap: true,
                        ),
                        tileColor: Colors.grey[300],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
