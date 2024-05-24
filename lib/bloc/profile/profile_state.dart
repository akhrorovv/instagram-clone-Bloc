import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {}

class ProfileInitialState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileErrorState extends ProfileState {
  final String message;

  ProfileErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoadPostsState extends ProfileState {
  @override
  List<Object?> get props => [];
}
