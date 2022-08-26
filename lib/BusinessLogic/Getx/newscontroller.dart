import 'package:get/get.dart';
import 'package:dio/dio.dart' as di;
import 'package:newsreader/BusinessLogic/Repository/diomodel.dart';
import 'package:newsreader/BusinessLogic/Repository/services.dart';
import '../Model/newsmodel.dart';

class NewsController extends GetxController with StateMixin<List<News>> {
  void loadNews(String article) async {
    change([], status: RxStatus.loading());
    try {
      Services services = Services();
      DioModel dioModel =
          DioModel(query: services.getNewsApiUrl(article), requestType: 'get');
      di.Response response = await dioModel.dioQuery();
      Map<String, dynamic> list = response.data;
      List<dynamic> fullList = list['articles'];
      List<News> newsList =
          fullList.map<News>((e) => News.fromJson(e)).toList();
      change(newsList, status: RxStatus.success());
    } catch (e) {
      change([], status: RxStatus.error());
    }
  }
}
