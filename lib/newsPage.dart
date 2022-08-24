import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsreader/Model/newsmodel.dart';
import 'package:dio/dio.dart';
import 'package:newsreader/newsDetail.dart';

class NewsPage extends StatefulWidget{
  const NewsPage({Key? key,required this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState()=>NewsView(title: title);
}
class NewsView extends State {
  NewsView({Key? key, required this.title});

  final String title;
 // late final List<News> newslist;

  @override
  Widget build(BuildContext context) {
   /* @override
    void initState() async {
      newslist = await readNews(title);
    }*/
    return Scaffold(
      backgroundColor: Colors.brown.shade600,
      appBar: AppBar(title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.transparent,),
      body: Center(
        child:Padding(padding: const EdgeInsets.all(15),
        child:FutureBuilder(builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData) {
            final data=snapshot.data as List<News>;
            /*return Center(
              child: Text(data[0].title,style:const TextStyle(color: Colors.white),),
            );*/
            return ListView.builder(
              itemCount: data.length,
                itemBuilder: (context,index){
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,height: 100,
                          child:
                          ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                            child:CachedNetworkImage(
                              imageUrl: data[index].urlToImage,fit: BoxFit.cover,
                              placeholder: (context, url) => Center(child:CircularProgressIndicator(color: Colors.brown.shade50,)),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Flexible(child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(data[index].title,style:const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(DateFormat('yyyy-MM-dd, kk:mm').format(DateTime.parse(data[index].publishedAt)).toString(),style:const TextStyle(color: Colors.black),),
                            ),
                          ],
                        ),
                        ),
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => NewsDetail(news: data[index],)));
                    },
                  ),
                );
            });
          }else{
            return const Center(child: CircularProgressIndicator(color: Colors.white,),);
          }
        },
          future: readNews(title),
        )),
      ),
    );
  }

  Future<List<News>> readNews(String article) async {
    Dio dio = Dio();
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: "https://newsapi.org")).interceptor);
    Response response = await dio.get(
        'https://newsapi.org/v2/everything?q=$article&apiKey=22841dcf65514b339fb7960f8cfaef58',
        options: buildCacheOptions(const Duration(days: 1),forceRefresh: true));
    Map<String, dynamic> list = response.data;
    List<dynamic> fullList = list['articles'];
    List<News> news =
    fullList.map<News>((e) => News.fromJson(e)).toList();
    return news;
  }
}