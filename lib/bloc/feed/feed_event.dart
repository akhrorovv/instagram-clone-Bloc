import 'package:equatable/equatable.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();
}

class LoadFeedPostsEvent extends FeedEvent {
  @override
  List<Object> get props => [];
}
