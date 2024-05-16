import 'package:equatable/equatable.dart';

import '../../../model/member_model.dart';

abstract class ItemMemberEvent extends Equatable {
  const ItemMemberEvent();
}

class FollowMemberEvent extends ItemMemberEvent {
  final Member member;

  const FollowMemberEvent(this.member);

  @override
  List<Object?> get props => [member];
}

class UnfollowMemberEvent extends ItemMemberEvent {
  final Member member;

  const UnfollowMemberEvent(this.member);

  @override
  List<Object?> get props => [member];
}
