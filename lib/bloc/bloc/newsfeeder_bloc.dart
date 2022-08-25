import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../Model/newsmodel.dart';
import 'package:newsreader/Model/diomodel.dart';
part 'newsfeeder_event.dart';
part 'newsfeeder_state.dart';

class NewsBloc extends Bloc<NewsfeederEvent, List<News>> {
  NewsBloc() : super(NewsState.initial()) {
    on<NewsLoadedEvent>(
      (event, emit) async {
        try {
          DioModel dioModel = DioModel(
              query:
                  'https://newsapi.org/v2/everything?q=${event.article}&apiKey=22841dcf65514b339fb7960f8cfaef58',
              requestType: 'get');
          Response response = await dioModel.dioQuery();
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
}
