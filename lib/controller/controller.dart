import 'package:englishbookworddiary/models/user.dart';
import 'package:get/get.dart';

class GetController extends GetxController {
  static GetController get to => Get.find();

  MyUser? googleUser;

  setGoogleUser(MyUser user) {
    this.googleUser = user;
    update();
  }
}
