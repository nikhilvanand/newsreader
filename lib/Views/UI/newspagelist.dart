import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsreader/BusinessLogic/Getx/newscontroller.dart';
import 'package:newsreader/Views/UI/newsDetail.dart';
import 'package:get/get.dart';
import 'package:newsreader/Views/Utils/Theme/LightTheme.dart';
import 'package:newsreader/Views/Utils/Theme/DarkTheme.dart';
import 'package:newsreader/Views/Utils/Widgets/MainPage/ListItems.dart';

class NewsPage extends StatelessWidget {
  final String title;
  NewsPage({super.key, this.title = 'News'});
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    newsController.loadNews(title);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            title,
            style: Theme.of(context).textTheme.caption,
          ),
          automaticallyImplyLeading: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: newsController.obx(
                (state) => ListView.builder(
                    itemCount: state?.length,
                    itemBuilder: (context, index) {
                      ListItems listItems = ListItems();
                      return listItems.getMainListItem(context, state![index]);
                    }),
                onLoading: const CircularProgressIndicator(
                  color: Colors.white,
                ),
                onEmpty: const Text('No Data'),
                onError: (error) => const Text(
                  'An Error Occured!\n Please check internet Connection',
                  textAlign: TextAlign.center,
                ),
              ),
            )));
  }
}
