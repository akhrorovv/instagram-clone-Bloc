import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../model/post_model.dart';

@immutable
abstract class FeedState extends Equatable {}

class FeedInitialState extends FeedState {
  @override
  List<Object?> get props => [];
}

class FeedLoadingState extends FeedState {
  @override
  List<Object?> get props => [];
}

class FeedErrorState extends FeedState {
  final String errorMessage;

  FeedErrorState(this.errorMessage);

  @override
  List<Object?> get props => [];
}

class FeedPostListState extends FeedState {
  final List<Post> postList;

  FeedPostListState(this.postList);

  @override
  List<Object> get props => [postList];
}