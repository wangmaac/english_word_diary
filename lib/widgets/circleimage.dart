import 'package:flutter/material.dart';

class CircleImageWidget extends StatelessWidget {
  final imageURL;
  final sizeWidth;
  const CircleImageWidget(this.imageURL, this.sizeWidth, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(100),
        ),
        width: sizeWidth,
        height: sizeWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            imageURL,
            fit: BoxFit.cover,
          ),
        ));
  }
}
