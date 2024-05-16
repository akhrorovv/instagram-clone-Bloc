import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/bloc/search_page/search_event.dart';
import 'package:instagram_clone/bloc/search_page/search_state.dart';

import '../../model/member_model.dart';
import '../../services/db_service.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<SearchMembersEvent>(_apiSearchMembers);
  }

  bool isLoading = false;
  var searchController = TextEditingController();
  List<Member> items = [];

  Future<void> _apiSearchMembers(SearchMembersEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());

    var result = await DBService.searchMembers(event.keyword);
    items = result;

    emit(SearchMembersState());
  }
}
