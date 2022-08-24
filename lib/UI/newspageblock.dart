import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newsreader/UI/newsDetail.dart';
import 'package:newsreader/bloc/bloc/newsfeeder_bloc.dart';

class NewsBlockPage extends StatelessWidget {
  final String title;
  NewsBlockPage({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsBloc(),
      child: _HomeView(
        title: title,
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  final String title;
  const _HomeView({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade800,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0,
        title: Text(
          title,
          //style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
            //direction: Axis.horizontal,
            child:
                BlocBuilder<NewsBloc, List<dynamic>>(builder: (context, data) {
          if (data.isEmpty) {
            context.read<NewsBloc>().add(NewsLoadedEvent(article: title));
            return const Text('');
          } else {
            return ListView.builder(
                itemCount: data.length,
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
                                imageUrl: data[index].urlToImage,
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
                                    data[index].title,
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
                                            data[index].publishedAt))
                                        .toString(),
                                    style: const TextStyle(color: Colors.black),
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
                                      news: data[index],
                                    )));
                      },
                    ),
                  );
                });
          }
        })),
      ),
    );
  }
}
