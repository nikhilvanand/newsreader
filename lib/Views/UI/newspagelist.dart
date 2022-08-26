import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsreader/BusinessLogic/Getx/newscontroller.dart';
import 'package:newsreader/Views/UI/newsDetail.dart';
import 'package:get/get.dart';
import 'package:newsreader/Views/Utils/Theme/LightTheme.dart';
import 'package:newsreader/Views/Utils/Theme/DarkTheme.dart';

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
        backgroundColor: Colors.brown.shade800,
        appBar: AppBar(
          //backgroundColor: Colors.brown,
          elevation: 0,
          title: Text(
            title,
            //style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: newsController.obx(
                (state) => ListView.builder(
                    itemCount: state?.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                  child: CachedNetworkImage(
                                    imageUrl: state![index].urlToImage,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.brown.shade50,
                                    )),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        state[index].title,
                                        maxLines: 3,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        DateFormat('yyyy-MM-dd, kk:mm')
                                            .format(DateTime.parse(
                                                state[index].publishedAt))
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsDetail(
                                          news: state[index],
                                        )));
                          },
                        ),
                      );
                    }),
                onLoading: const CircularProgressIndicator(
                  color: Colors.white,
                ),
                //onError: Text('Something Error Happened!'),
              ),
            )));
  }
}
