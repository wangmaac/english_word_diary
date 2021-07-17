import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:flutter/material.dart';

class BookViewPage extends StatelessWidget {
  final QueryDocumentSnapshot document;

  const BookViewPage({required this.document, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> currentStream = document.reference.collection('Words').snapshots();
    //final Future<QuerySnapshot> currentStream = document.reference.collection('Words').get();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text('${document['title']}'),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Image.network(
              '${document['imageURL']}',
              fit: BoxFit.cover,
            ),
          ),
          Flexible(
              flex: 2,
              child: StreamBuilder(
                stream: currentStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error:${snapshot.error}'),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            dense: true,
                            title: Text(
                              '${snapshot.data!.docs[index]['title']}',
                              style: kMainTextPTSans.copyWith(fontWeight: FontWeight.w700),
                            ),
                            visualDensity: VisualDensity.standard,
                            leading: Text('${snapshot.data!.docs[index]['type']}'),
                            subtitle: Text('${snapshot.data!.docs[index]['content']}'),
                            tileColor: Colors.grey[300],
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )),
        ],
      ),
    );
  }
}
