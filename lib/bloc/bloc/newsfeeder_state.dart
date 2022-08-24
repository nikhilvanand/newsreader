part of 'newsfeeder_bloc.dart';

abstract class NewsState {
  static List<News> initial() {
    List<News> list = [];
    return list;
  }
}

class NewsInitial extends NewsState {}
