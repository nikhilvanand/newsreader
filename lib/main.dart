import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:newsreader/BusinessLogic/Getx/homecontroller.dart';
import 'package:newsreader/BusinessLogic/Getx/newscontroller.dart';
import 'package:newsreader/Views/UI/newspagelist.dart';
import 'package:newsreader/Views/Utils/Theme/LightTheme.dart';
import 'package:newsreader/Views/Utils/Theme/DarkTheme.dart';
import 'package:newsreader/Views/Utils/Lists/MainPage/MenuList.dart';
import 'package:get/get.dart';
import 'package:newsreader/Views/Utils/Widgets/MainPage/ListItems.dart';

import 'BusinessLogic/Model/newsmodel.dart';
import 'Views/UI/newsDetail.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: CommonLightTheme().themedata,
      darkTheme: CommonDarkTheme().themedata,
      home: MyHomePage(title: 'News'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  final HomeCOntroller controller = Get.put(HomeCOntroller());
  final NewsController newsController = Get.put(NewsController());
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  final ListItems listItems = ListItems();
  final Menulist menulist = Menulist();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.brown.shade600,
      appBar: AppBar(
        title: Text(
          'News',
          style: Theme.of(context).textTheme.caption,
        ),
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
      body: SingleChildScrollView(
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Colors.white,
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                newsList[index].urlToImage,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Center(
                                                    child:
                                                        CircularProgressIndicator(
                                              color: Colors.brown.shade50,
                                            )),
                                            errorWidget:
                                                (context, url, error) =>
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
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
                          child:
                              Text('An error occured please check internet!'),
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
                    return listItems.getMainMenuItem(context, index);
                  }),
                )),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: CurvedNavigationBar(
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
            newsController.tabIndex.value = index;
            switch (index) {
              case 0:
                Get.to(MyHomePage(
                  title: menulist.newsquery[index],
                ));
                break;
              case 1:
                Get.to(NewsPage());
                break;
            }
          },
        ),
      ),
    );
  }
}
