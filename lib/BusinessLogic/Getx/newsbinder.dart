import 'package:get/get.dart';
import 'package:newsreader/BusinessLogic/Getx/newscontroller.dart';

class NewsBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewsController());
  }
}
