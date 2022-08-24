import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsreader/Model/newsmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatefulWidget{
  const NewsDetail({Key? key,required this.news}) : super(key: key);
  final News news;
  @override
  State<StatefulWidget> createState()=>DetailView(news: news);
}
class DetailView extends State {
  DetailView({Key? key, required this.news});
  final News news;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Back to List'),
        //centerTitle: true,
        backgroundColor: Colors.brown.shade600,),
      body: SingleChildScrollView(
        child:Padding(padding: const EdgeInsets.all(10),
                      child:Expanded(child:Card(
                        elevation: 0,
                       // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child:CachedNetworkImage(
                                      imageUrl: news.urlToImage,fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(child:CircularProgressIndicator(color: Colors.brown.shade100,)),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(news.title,style:const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:20 ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(DateFormat('yyyy-MM-dd, kk:mm').format(DateTime.parse(news.publishedAt)).toString(),style:const TextStyle(color: Colors.black),),
                                      //var todayDate = DateFormat("yyyy-MM-dd", "en_US").parse(news.publishedAt);
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(news.description,style:const TextStyle(color: Colors.black),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(news.content,style:const TextStyle(color: Colors.black),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextButton(onPressed: () async{
                                      Uri uri=Uri.parse(news.url);
                                      /*if (! await launchUrl(uri)) {
                                      throw 'Could not launch Url';
                                      }else
                                        {*/
                                          await launchUrl(uri);
                                        //}
                                    },
                                    child:const Align(
                                      alignment: Alignment.centerRight,
                                      child:Text('Source',textAlign: TextAlign.end,
                                          style:TextStyle(color: Colors.black)),
                                    ),
                                    ),
                                  ),
                                ],
                              ),
                              ),
                      )

      ),
    ));
  }
}