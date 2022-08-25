import 'package:get/get.dart';
import 'package:newsreader/Getx/newscontroller.dart';

class NewsBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewsController());
  }
}
