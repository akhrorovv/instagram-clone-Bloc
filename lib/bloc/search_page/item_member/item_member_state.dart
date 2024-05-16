import 'package:equatable/equatable.dart';
import 'package:instagram_clone/model/post_model.dart';

import '../../../model/member_model.dart';

abstract class ItemMemberState extends Equatable {
  const ItemMemberState();
}

class ItemMemberInitialState extends ItemMemberState {
  @override
  List<Object?> get props => [];
}

class ItemMemberLoadingState extends ItemMemberState {
  @override
  List<Object?> get props => [];
}

class FollowMemberState extends ItemMemberState {
  final Member member;

  const FollowMemberState(this.member);

  @override
  List<Object?> get props => [member];
}

class UnfollowMemberState extends ItemMemberState {
  final Member member;

  const UnfollowMemberState(this.member);

  @override
  List<Object?> get props => [member];
}
