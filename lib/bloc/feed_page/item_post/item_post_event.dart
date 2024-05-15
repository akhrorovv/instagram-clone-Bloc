import 'package:equatable/equatable.dart';
import 'package:instagram_clone/model/post_model.dart';

abstract class ItemPostEvent extends Equatable {
  const ItemPostEvent();
}

class LikePostEvent extends ItemPostEvent {
  final Post post;

  const LikePostEvent(this.post);

  @override
  List<Object?> get props => [post];
}

class UnlikePostEvent extends ItemPostEvent {
  final Post post;

  const UnlikePostEvent(this.post);

  @override
  List<Object?> get props => [post];
}

class RemovePostEvent extends ItemPostEvent {
  final Post post;

  const RemovePostEvent(this.post);

  @override
  List<Object?> get props => [post];
}
