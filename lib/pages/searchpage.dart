import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> tmpList = [
      {'title': 'Pet life', 'count': 2},
      {'title': 'Gorilla champ', 'count': 21},
      {'title': 'Dreaming', 'count': 12},
      {'title': 'Sing a song', 'count': 9},
      {'title': 'Fear of stranger', 'count': 39},
    ];

    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        searchBar(context),
        SizedBox(
          height: 20,
        ),
        searchBookWidget(context, tmpList),
        Row(),
      ],
    ));
  }

  Widget searchBar(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
        width: MediaQuery.of(context).size.width * 0.9,
        alignment: Alignment.centerLeft,
        height: 50,
        child: TextField(
          style: kMainTextPTSans.copyWith(fontSize: 18, fontWeight: FontWeight.w700),
          onSubmitted: (value) {
            print(value);
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

  Widget searchBookWidget(BuildContext context, List tmpList) {
    return Expanded(
      child: GridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.vertical, //스크롤 방향 조절
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        childAspectRatio: 4 / 5,
        mainAxisSpacing: 5,
        children: List.generate(tmpList.length, (index) {
          return Card(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Flexible(
                  flex: 6,
                  child: ClipRRect(
                    // borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                    child: Image.network(
                      'http://files.picturebookmakers.com/images/posts/20150607-benji-davies/x2/7.jpg',
                      //'https://assets.bigcartel.com/product_images/216491836/Song+Picturebook.jpg?auto=format&fit=max&w=1500',
                      fit: BoxFit.cover,
                    ),
                  )),
              Flexible(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${tmpList[index]['title']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kMainTextPTSans.copyWith(fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                      Text(
                        'word count : ${tmpList[index]['count']}',
                        overflow: TextOverflow.ellipsis,
                        style: kMainTextPTSans.copyWith(color: Colors.grey, fontSize: 12),
                      ),
                      Row()
                    ],
                  ),
                ),
              ),
            ]),
          );
        }),
      ),
    );
  }
}
