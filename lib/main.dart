import 'package:cached_network_image/cached_network_image.dart';
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
              height: 200,
              width: newsController.screenSize.width,
              //width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Obx(() => FutureBuilder(
                    //initialData: const [],
                    future: newsController.loadNewsQuery(
                        menulist.newsquery[newsController.favIndex.value]),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List<News> newsList = snapshot.data as List<News>;
                        return ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, int index) {
                              return SizedBox(
                                // height: 200,
                                width: newsController.screenSize.width * .7,
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
                                            height: 200,
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
      bottomNavigationBar: Obx((() => SnakeNavigationBar.color(
            behaviour: SnakeBarBehaviour.pinned,
            snakeShape: SnakeShape.circle,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            padding: EdgeInsets.zero,

            ///configuration for SnakeNavigationBar.color
            snakeViewColor: Color(0xFFb5838d),
            selectedItemColor: SnakeShape.circle == SnakeShape.indicator
                ? Colors.purple
                : null,
            unselectedItemColor: Theme.of(context).primaryColorDark,

            ///configuration for SnakeNavigationBar.gradient
            //snakeViewGradient: selectedGradient,
            //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
            //unselectedItemGradient: unselectedGradient,

            showUnselectedLabels: true,
            showSelectedLabels: true,

            currentIndex: newsController.tabIndex.value,
            onTap: (value) {
              newsController.tabIndex.value = value;
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search')
            ],
          ))),
    );
  }
}
