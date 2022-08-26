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

  const NewsPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CommonLightTheme().themedata,
      darkTheme: CommonDarkTheme().themedata,
      home: NewsPageState(title: title),
    );
  }
}

class NewsPageState extends StatefulWidget {
  final String title;
  const NewsPageState({Key? key, required this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomeView(title: title);
}

class _HomeView extends State {
  late final String title;
  _HomeView({required this.title});
  final NewsController newsController = Get.put(NewsController());
  @override
  void initState() {
    super.initState();
    newsController.loadNews(title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            title,
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
              ),
            )));
  }
}
