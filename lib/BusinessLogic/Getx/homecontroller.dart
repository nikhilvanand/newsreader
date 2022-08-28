import 'package:get/get.dart';

class HomeCOntroller extends GetxController {
  var favourite = ''.obs;
  var favIndex = 0.obs;
  void setFavourite(String fav) {
    favourite.value = fav;
  }
}
