import 'package:equatable/equatable.dart';

import '../../model/post_model.dart';

abstract class LikesState extends Equatable {}

class InitialState extends LikesState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends LikesState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class LoadingState extends LikesState {
  @override
  List<Object?> get props => [];
}

class LoadPostState extends LikesState {
  final List<Post> posts;

  LoadPostState(this.posts);

  @override
  List<Object?> get props => [];
}
