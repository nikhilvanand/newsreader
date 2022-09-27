import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as di;
import 'package:newsreader/BusinessLogic/Repository/diomodel.dart';
import 'package:newsreader/BusinessLogic/Repository/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/newsmodel.dart';

class NewsController extends GetxController with StateMixin<List<News>> {
  final Size screenSize = Get.size;
  var favIndex = 0.obs;
  var tabIndex = 0.obs;
  @override
  void onInit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    favIndex.value = sharedPreferences.getInt('fav') ?? 0;
    super.onInit();
  }

  Future<void> setFavourite(int fav) async {
    favIndex.value = fav;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('fav', favIndex.value);
  }

  void loadNews(String article) async {
    change([], status: RxStatus.loading());
    try {
      Services services = Services();
      DioModel dioModel = DioModel(
          query: services.getNewsApiUrl(article),
          requestType: 'get',
          options: buildCacheOptions(const Duration(hours: 1)));
      di.Response response = await dioModel.dioQuery(); // Api call Object
      Map<String, dynamic> list = response.data;
      List<dynamic> fullList = list['articles'];
      List<News> newsList = fullList
          .map<News>((e) => News.fromJson(e))
          .toList(); //Model Class Mapping
      change(newsList, status: RxStatus.success());
    } catch (e) {
      change([], status: RxStatus.error(e.toString()));
    }
  }

  Future<List<News>> loadNewsQuery(String article) async {
    Services services = Services();
    DioModel dioModel = DioModel(
        query: services.getNewsApiUrl(article),
        requestType: 'get',
        options: buildCacheOptions(const Duration(hours: 1)));
    di.Response response = await dioModel.dioQuery(); // Api call Object
    Map<String, dynamic> list = response.data;
    List<dynamic> fullList = list['articles'];
    List<News> newsList = fullList
        .map<News>((e) => News.fromJson(e))
        .toList(); //Model Class Mapping
    return newsList;
  }
}
