import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
//import 'package:newsreader/BusinessLogic/Getx/homecontroller.dart';
import 'package:newsreader/BusinessLogic/Getx/newscontroller.dart';
import 'package:newsreader/Views/Utils/Theme/LightTheme.dart';
import 'package:newsreader/Views/Utils/Theme/DarkTheme.dart';
import 'package:newsreader/Views/Utils/Lists/MainPage/MenuList.dart';
import 'package:get/get.dart';
import 'package:newsreader/Views/Utils/Widgets/MainPage/ListItems.dart';
import 'package:path_provider/path_provider.dart';

import 'BusinessLogic/Model/newsmodel.dart';
import 'Views/UI/newsDetail.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final NewsController newsController = Get.put(NewsController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News',
      theme: CommonLightTheme().themedata,
      darkTheme: CommonDarkTheme().themedata,
      home: MyHomePage(title: 'News'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  //final HomeCOntroller controller = Get.put(HomeCOntroller());
  final NewsController newsController = Get.find();
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  final ListItems listItems = ListItems();
  final Menulist menulist = Menulist();

  @override
  Widget build(BuildContext context) {
    List<Widget> pageList = [homePage(context), searchPage(context)];
    return Scaffold(
      //backgroundColor: Colors.brown.shade600,
      appBar: AppBar(
        title: Obx(() => Text(
              newsController.searchArticle.value.toUpperCase(),
              style: Theme.of(context).textTheme.caption,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          //Text(controller.favourite.value),
          IconButton(
              onPressed: () {
                Get.isDarkMode
                    ? Get.changeTheme(CommonLightTheme().themedata)
                    : Get.changeTheme(CommonDarkTheme().themedata);
              },
              icon: const Icon(
                Icons.invert_colors,
                color: Colors.grey,
              ))
        ],
      ),
      body: Obx(() => pageList[newsController.tabIndex
          .value]), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: CurvedNavigationBar(
            index: newsController.tabIndex.value,
            height: 55,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            color: Theme.of(context).backgroundColor,
            buttonBackgroundColor: Theme.of(context).backgroundColor,
            items: <Widget>[
              Icon(
                Icons.home,
                size: 30,
                color: Theme.of(context).primaryColorLight,
              ),
              Icon(
                Icons.search,
                size: 30,
                color: Theme.of(context).primaryColorLight,
              ),
            ],
            onTap: (index) {
              newsController.searchArticle.value = index == 0 ? 'News' : '';
              newsController.tabIndex.value = index;
              newsController.loadNews();
            },
          ),
        ),
      ),
    );
  }

  Widget homePage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height / 4,
            width: Get.width,
            //width: double.infinity,
            child: Obx(() => FutureBuilder(
                //initialData: const [],
                future: newsController.loadNewsQuery(
                    menulist.newsquery[newsController.favIndex.value]),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data == null) {
                    return const Center(
                      child: Text('No data!'),
                    );
                  } else if (snapshot.hasData) {
                    List<News> newsList = snapshot.data as List<News>;
                    return ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int index) {
                          return SizedBox(
                            // height: 200,
                            width: Get.width * .7,
                            child: InkWell(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.white,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: newsList[index].urlToImage,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                          color: Colors.brown.shade50,
                                        )),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        height: Get.height / 4,
                                      ),
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: const LinearGradient(
                                              colors: [
                                                Colors.transparent,
                                                Colors.black
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Text(
                                            newsList[index].title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(color: Colors.white),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Get.to(NewsDetail(
                                  news: newsList[index],
                                ));
                              },
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error occured please check internet!'),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(top: 4), //menuCard
                child: Obx(() => GridView.count(
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 3,
                      childAspectRatio: .7,
                      children: List.generate(
                          newsController.favs.length,
                          (index) => listItems.topNewsCard(
                              context, newsController.favs[index])),
                    ))),
          ),
        ],
      ),
    );
  }

  Widget searchPage(BuildContext context) {
    //TextEditingController textEditingController = TextEditingController();
    // newsController.loadNews();
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => FutureBuilder(
                    //initialData: const [],
                    future: newsController
                        .loadNewsQuery(newsController.searchArticle.value),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        List<News> newsList = snapshot.data as List<News>;
                        if (newsList.isEmpty) {
                          return const Center(
                            child: Text('No Data!'),
                          );
                        } else {
                          return ListView.builder(
                              itemCount: newsList.length,
                              itemBuilder: (context, index) {
                                ListItems listItems = ListItems();
                                return listItems.searchCard(
                                    context, newsList[index]);
                              });
                        }
                      } else if (snapshot.hasError) {
                        return const Center(
                          child:
                              Text('An error occured please check internet!'),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoSearchTextField(
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                          //controller: textEditingController,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 8),
                          onSubmitted: (value) {
                            //newsController.loadNews(article: value);
                            newsController.searchArticle.value = value;
                            newsController.writePrefHive(value);
                          }),
                    ),
                    IconButton(
                        onPressed: (() async {
                          /* List<String> favs =
                              await newsController.readPrefHive(); */
                          Get.snackbar('title', newsController.favs.toString());
                        }),
                        icon: const Icon(Icons.gesture))
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
