import 'package:flutter/material.dart';
import 'package:newsreader/Views/UI/newspagelist.dart';
import 'package:newsreader/Views/Utils/Theme/LightTheme.dart';
import 'package:newsreader/Views/Utils/Theme/DarkTheme.dart';
import 'package:newsreader/Views/Utils/Lists/MainPage/MenuList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            children: [
              SizedBox(
                height: 160,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(
                            'Assets/MainScreen/Images/${menulist.assetimages[0]}'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).primaryColor, BlendMode.darken),
                      ),
                      /*gradient: const LinearGradient(
                          colors: [Colors.white, Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),*/
                    ),
                    child: InkWell(
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(menulist.newsquery[0],
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline5),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsPage(
                                      title: menulist.newsquery[0],
                                    )));
                      },
                    ),
                  ),
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
                      return Card(
                          elevation: 0,
                          color: Colors.black.withOpacity(0.1),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: InkWell(
                            child: Column(
                              //alignment: Alignment.topCenter,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'Assets/MainScreen/Images/${menulist.assetimages[index + 1]}'),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Theme.of(context).primaryColor,
                                            BlendMode.darken),
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          menulist.newsquery[index + 1],
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsPage(
                                            title:
                                                menulist.newsquery[index + 1],
                                          )));
                            },
                          ));
                    }),
                  )),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  /*final List<String> newsquery = [
    'Google',
    'Apple',
    'Tesla',
    'Amazon',
    'Microsoft',
    'Business',
    'Sports',
    'Entertainment',
    'Gadgets',
  ];
  final List<String> assetimages = [
    'google.png',
    'apple.png',
    'tesla.png',
    'amazon.png',
    'microsoft.png',
    'business.png',
    'sports.png',
    'entertainment.png',
    'gadgets.png',
  ];*/
}
