import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:newsreader/BusinessLogic/Getx/homecontroller.dart';
import 'package:newsreader/BusinessLogic/Getx/newscontroller.dart';
import 'package:newsreader/Views/Utils/Theme/LightTheme.dart';
import 'package:newsreader/Views/Utils/Theme/DarkTheme.dart';
import 'package:newsreader/Views/Utils/Lists/MainPage/MenuList.dart';
import 'package:get/get.dart';
import 'package:newsreader/Views/Utils/Widgets/MainPage/ListItems.dart';

import 'BusinessLogic/Model/newsmodel.dart';
import 'Views/UI/newsDetail.dart';

void main() {
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
              newsController.searchArticle.value,
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
          padding: const EdgeInsets.only(top: 16.0),
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
              newsController.searchArticle.value =
                  index == 0 ? 'News' : 'Search';
              newsController.tabIndex.value = index;
              newsController.loadNews();
            },
          ),
        ),
      ),
    );
  }

  Widget homePage(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height / 4,
            width: newsController.screenSize.width,
            //width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Obx(() => FutureBuilder(
                  //initialData: const [],
                  future: newsController.loadNewsQuery(
                      menulist.newsquery[newsController.favIndex.value]),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
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
                                                  .copyWith(
                                                      color: Colors.white),
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
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.count(
                childAspectRatio: 0.7,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                children: List.generate(menulist.newsquery.length, (index) {
                  return listItems.topNewsCard(context, index);
                }),
              )),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 4, right: 4),
              child: CupertinoSearchTextField(
                //controller: textEditingController,
                padding: const EdgeInsets.symmetric(vertical: 12),
                onSubmitted: (value) => newsController.loadNews(article: value),
              ),
            ),
            Expanded(
              child: newsController.obx(
                (state) => ListView.builder(
                    itemCount: state?.length,
                    itemBuilder: (context, index) {
                      ListItems listItems = ListItems();
                      return listItems.getMainListItem(context, state![index]);
                    }),
                onLoading: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
                onEmpty: const Text('No Data'),
                onError: (error) => const Text(
                  'An Error Occured!\n Please check internet Connection',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ));
  }
}
