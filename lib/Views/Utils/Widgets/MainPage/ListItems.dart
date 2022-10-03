import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newsreader/BusinessLogic/Getx/newscontroller.dart';
import '../../../../BusinessLogic/Model/newsmodel.dart';
import '../../../UI/newsDetail.dart';
import 'package:newsreader/Views/Utils/Lists/MainPage/MenuList.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ListItems {
  NewsController newsController = Get.find();
  Card searchCard(BuildContext context, News state) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                  imageUrl: state.urlToImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                    color: Colors.brown.shade50,
                  )),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      state.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      DateFormat('yyyy-MM-dd, kk:mm')
                          .format(DateTime.parse(state.publishedAt))
                          .toString(),
                      /* style: const TextStyle(color: Colors.black), */
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
                        news: state,
                      )));
        },
      ),
    );
  }

  Card topNewsCard(BuildContext context, String index) {
    Menulist menulist = Menulist();
    return Card(
        elevation: 6,
        //color: Colors.black.withOpacity(0.1),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: InkWell(
          child: Column(children: [
            Flexible(
              //fit: FlexFit.tight,
              flex: 4,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.asset(
                      'Assets/MainScreen/Images/image.png',
                      color: Colors.blueGrey.shade50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          //color: Colors.blueGrey,
                          alignment: Alignment.center,
                          child: const Text(
                            'Image!',
                            //style: TextStyle(fontSize: 30),
                          ),
                        );
                      },
                      //height: 80,
                      //width: double.infinity,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_outline,
                              color: Colors.green,
                              size: 15,
                            )),
                      ),
                      //const Spacer(),
                      Expanded(
                        child: IconButton(
                            onPressed: () {
                              newsController.deletePrefHive(index);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 15,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FittedBox(
                    child: Text(
                      index,
                      textAlign: TextAlign.center,
                      // style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            //)
          ]),
          onTap: () {
            //newsController.loadNews(article: menulist.newsquery[index]);
            newsController.searchArticle.value = index;
            newsController.tabIndex.value = 1;
            /* Get.to(NewsPage(
              title: menulist.newsquery[index],
            )); */

            /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsPage(
                          title: menulist.newsquery[index],
                        )));*/
          },
          /* onLongPress: () async {
            //HomeCOntroller controller = Get.find();
            newsController.setFavourite(index);
            //controller.favourite.value = menulist.newsquery[index];
          }, */
        ));
  }
}
