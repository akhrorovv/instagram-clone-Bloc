import 'package:equatable/equatable.dart';

abstract class LikesEvent extends Equatable {}

class LoadPostEvent extends LikesEvent {
  @override
  List<Object?> get props => [];
}
