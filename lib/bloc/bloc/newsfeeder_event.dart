part of 'newsfeeder_bloc.dart';

abstract class NewsfeederEvent {}

class NewsLoadedEvent extends NewsfeederEvent {
  final String article;
  NewsLoadedEvent({required this.article});
}

class NewsLoadingEvent extends NewsfeederEvent {}
