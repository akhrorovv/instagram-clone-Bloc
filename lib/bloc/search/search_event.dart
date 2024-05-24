import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class LoadSearchMembersEvent extends SearchEvent {
  String keyword;

  LoadSearchMembersEvent({required this.keyword});

  @override
  List<Object> get props => [];
}
