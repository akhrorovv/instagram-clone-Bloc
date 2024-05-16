import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {}

class SearchInitialState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchLoadingState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchMembersState extends SearchState {
  @override
  List<Object?> get props => [];
}