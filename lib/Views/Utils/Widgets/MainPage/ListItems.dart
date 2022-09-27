import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newsreader/BusinessLogic/Getx/homecontroller.dart';
import 'package:newsreader/BusinessLogic/Getx/newscontroller.dart';
import '../../../../BusinessLogic/Model/newsmodel.dart';
import '../../../UI/newsDetail.dart';
import 'package:newsreader/Views/Utils/Lists/MainPage/MenuList.dart';

import '../../../UI/newspagelist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListItems {
  NewsController newsController = Get.find();
  Card getMainListItem(BuildContext context, News state) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              height: 120,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      state.title,
                      maxLines: 3,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      DateFormat('yyyy-MM-dd, kk:mm')
                          .format(DateTime.parse(state.publishedAt))
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
                        news: state,
                      )));
        },
      ),
    );
  }

  Card getMainMenuItem(BuildContext context, int index) {
    Menulist menulist = Menulist();
    return Card(
        elevation: 0,
        //color: Colors.black.withOpacity(0.1),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    'Assets/MainScreen/Images/${menulist.assetimages[index]}',
                    fit: BoxFit.cover,
                    //height: 80,
                    width: double.infinity,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: FittedBox(
                      child: Text(
                        menulist.newsquery[index],
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                ),
              ),
              Obx((() => Flexible(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: FittedBox(
                          child: TextButton.icon(
                            onPressed: () {
                              newsController.setFavourite(index);
                            },
                            icon: newsController.favIndex.value == index
                                ? const Icon(Icons.favorite)
                                : const Icon(Icons.favorite_outline),
                            label: const Text('Favourite'),
                          ),
                        ),
                      ),
                    ),
                  ))),
              //)
            ]),
          ),
          onTap: () {
            Get.to(NewsPage(
              title: menulist.newsquery[index],
            ));
            /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsPage(
                          title: menulist.newsquery[index],
                        )));*/
          },
          onLongPress: () async {
            //HomeCOntroller controller = Get.find();
            newsController.setFavourite(index);
            //controller.favourite.value = menulist.newsquery[index];
          },
        ));
  }
}
