import 'package:get/get.dart';

class GetController extends GetxController {
  static GetController get to => Get.find();

  String searchBookTitle = '';
  List<String> kakaoBookList = [];

  insertKakaoBookList(List<String> list) {
    this.kakaoBookList = list;
    update();
  }
}
