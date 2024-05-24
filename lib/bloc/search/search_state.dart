import '../../model/member_model.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  List<Member> items;

  SearchSuccessState({required this.items});
}

class SearchFailureState extends SearchState {
  final String errorMessage;

  SearchFailureState(this.errorMessage);
}
