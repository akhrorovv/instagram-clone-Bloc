import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {}

class SearchMembersEvent extends SearchEvent {
  final String keyword;

  SearchMembersEvent(this.keyword);

  @override
  List<Object?> get props => [];
}