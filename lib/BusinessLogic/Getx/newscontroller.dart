import 'dart:developer';
import 'dart:io';

import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as di;
import 'package:newsreader/BusinessLogic/Repository/diomodel.dart';
import 'package:newsreader/BusinessLogic/Repository/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/newsmodel.dart';
import 'package:hive/hive.dart';

class NewsController extends GetxController {
  final Size screenSize = Get.size;
  var favIndex = 0.obs;
  var tabIndex = 0.obs;
  var searchArticle = 'News'.obs;
  String hiveName = 'favs';
  var favs = <String>[].obs;
  /* var path = Directory.current.path; */

  @override
  void onInit() async {
    /*    Directory temp = await getApplicationDocumentsDirectory();
    Hive.init(temp.path);
    log(temp.path); */
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    favIndex.value = sharedPreferences.getInt('fav') ?? 0;

    readPrefHive();
    super.onInit();
  }

  Future writePrefHive(String tag) async {
    var box = await Hive.openBox(hiveName);
    //List<String> favs = [];
    if (box.get('favs') == null) {
      favs.value = [tag];
    } else if (box.get('favs') is String) {
      favs.value = [box.get('favs'), tag];
    } else if (box.get('favs') == []) {
      favs.value = [tag];
    } else {
      /* favs.clear();
      favs.addAll(box.get('favs')); */
      favs.add(tag);
    }
    //favs.add(tag);
    box.put('favs', favs);
  }

  void readPrefHive() async {
    var box = await Hive.openBox(hiveName);
    //List<String> favs = [];
    if (box.get('favs') == null) {
      //return favs;
    } else if (box.get('favs') is String) {
      favs.value = [box.get('favs')];
    } else {
      favs.clear();
      favs.addAll(box.get('favs'));
    }
  }

  Future deletePrefHive(String tag) async {
    var box = await Hive.openBox(hiveName);
    if (favs.length > 1) {
      favs.remove(tag);
      box.put('favs', favs);
    } else {
      Get.snackbar('Warning', 'At least one topic is needed!');
    }
  }

  Future<void> setFavourite(int fav) async {
    favIndex.value = fav;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('fav', favIndex.value);
  }

  Future<List<News>> loadNews({String article = ''}) async {
    Services services = Services();
    DioModel dioModel = DioModel(
        query: services.getNewsApiUrl(article),
        requestType: 'get',
        options: buildCacheOptions(const Duration(hours: 1)));
    di.Response response = await dioModel.dioQuery(); // Api call Object
    Map<String, dynamic> list = response.data;
    List<dynamic> fullList = list['articles'];
    List<News> newsList = fullList.map<News>((e) => News.fromJson(e)).toList();
    return newsList; //Model Class Mapping
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
