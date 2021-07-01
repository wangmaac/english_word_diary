import 'package:flutter/material.dart';

class BookViewPage extends StatelessWidget {
  const BookViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text('Book Name'),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Image.network(
              'http://files.picturebookmakers.com/images/posts/20150607-benji-davies/x2/7.jpg',
              //'https://assets.bigcartel.com/product_images/216491836/Song+Picturebook.jpg?auto=format&fit=max&w=1500',
              fit: BoxFit.cover,
            ),
          ),
          Flexible(
              flex: 2,
              child: ListView.builder(
                itemCount: 13,
                itemBuilder: (context, int) {
                  return Card(
                    child: ListTile(
                      title: Text('title'),
                      visualDensity: VisualDensity.standard,
                      trailing: Text('trailing'),
                      leading: Text('leading'),
                      subtitle: Text('subtitle'),
                      tileColor: Colors.grey,
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
