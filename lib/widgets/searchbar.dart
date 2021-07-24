import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englishbookworddiary/utilities/constants.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController();
    return Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
        width: MediaQuery.of(context).size.width * 0.9,
        alignment: Alignment.centerLeft,
        height: 50,
        child: TextField(
          controller: _controller,
          style: kMainTextPTSans.copyWith(fontSize: 18, fontWeight: FontWeight.w700),
          onSubmitted: (value) {},
          keyboardType: TextInputType.text,
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
}
