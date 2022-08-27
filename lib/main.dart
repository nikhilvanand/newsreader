import 'package:flutter/material.dart';
import 'package:newsreader/Views/UI/newspagelist.dart';
import 'package:newsreader/Views/Utils/Theme/LightTheme.dart';
import 'package:newsreader/Views/Utils/Theme/DarkTheme.dart';
import 'package:newsreader/Views/Utils/Lists/MainPage/MenuList.dart';
import 'package:get/get.dart';
import 'package:newsreader/Views/Utils/Widgets/MainPage/ListItems.dart';

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
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  ListItems listItems = ListItems();
  Menulist menulist = Menulist();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.brown.shade600,
        appBar: AppBar(
          title: const Text('News'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 160,
                //width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Stack(children: [
                    ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image.asset(
                          'Assets/MainScreen/Images/${menulist.assetimages[0]}',
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Theme.of(context).primaryColorLight
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      child: InkWell(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 20),
                            child: Text(menulist.newsquery[0],
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline5),
                          ),
                        ),
                        onTap: () {
                          Get.to(NewsPage(
                            title: menulist.newsquery[0],
                          ));
                        },
                      ),
                    ),
                  ]),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children:
                        List.generate(menulist.newsquery.length - 1, (index) {
                      return listItems.getMainMenuItem(context, index);
                    }),
                  )),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
