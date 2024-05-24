import 'package:equatable/equatable.dart';

import '../../model/post_model.dart';

abstract class ProfileEvent extends Equatable {}

class LoadProfilePostsEvent extends ProfileEvent {
  List<Post> items = [];

  LoadProfilePostsEvent(this.items);

  @override
  List<Object?> get props => [];
}
