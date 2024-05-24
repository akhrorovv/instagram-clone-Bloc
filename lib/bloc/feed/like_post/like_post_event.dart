import 'package:equatable/equatable.dart';

import '../../../model/post_model.dart';

abstract class LikedEvent extends Equatable {
  const LikedEvent();
}

class LikePostEvent extends LikedEvent {
  Post post;

  LikePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class UnLikePostEvent extends LikedEvent {
  Post post;

  UnLikePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}
