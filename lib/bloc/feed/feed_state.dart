import '../../model/post_model.dart';

abstract class FeedState {}

class FeedInitialState extends FeedState {}

class FeedLoadingState extends FeedState {}

class FeedSuccessState extends FeedState {
  List<Post> items;

  FeedSuccessState({required this.items});
}

class FeedFailureState extends FeedState {
  final String errorMessage;

  FeedFailureState(this.errorMessage);
}