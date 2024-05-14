import 'package:equatable/equatable.dart';

import '../model/post_model.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();
}

class LoadPostListEvent extends FeedEvent {
  @override
  List<Object?> get props => [];
}
