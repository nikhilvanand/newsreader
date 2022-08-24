import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import '../../Model/newsmodel.dart';

part 'newsfeeder_event.dart';
part 'newsfeeder_state.dart';

class NewsBloc extends Bloc<NewsfeederEvent, List<News>> {
  NewsBloc() : super(NewsState.initial()) {
    on<NewsLoadedEvent>(
      (event, emit) async {
        try {
          Dio dio = Dio();
          dio.interceptors.add(
              DioCacheManager(CacheConfig(baseUrl: "https://newsapi.org"))
                  .interceptor);
          Response response = await dio.get(
              'https://newsapi.org/v2/everything?q=${event.article}&apiKey=22841dcf65514b339fb7960f8cfaef58',
              options: buildCacheOptions(const Duration(days: 1),
                  forceRefresh: true));
          Map<String, dynamic> list = response.data;
          List<dynamic> fullList = list['articles'];
          List<News> news =
              fullList.map<News>((e) => News.fromJson(e)).toList();
          emit(news);
        } catch (e) {
          emit([]);
        }
      },
    );
  }
  Future<List<News>> readNews(String article) async {
    Dio dio = Dio();
    dio.interceptors.add(
        DioCacheManager(CacheConfig(baseUrl: "https://newsapi.org"))
            .interceptor);
    Response response = await dio.get(
        'https://newsapi.org/v2/everything?q=$article&apiKey=22841dcf65514b339fb7960f8cfaef58',
        options:
            buildCacheOptions(const Duration(days: 1), forceRefresh: true));
    Map<String, dynamic> list = response.data;
    List<dynamic> fullList = list['articles'];
    List<News> news = fullList.map<News>((e) => News.fromJson(e)).toList();
    return news;
  }
}
