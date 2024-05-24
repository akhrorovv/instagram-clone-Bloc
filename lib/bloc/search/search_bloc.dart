import 'package:bloc/bloc.dart';
import 'package:instagram_clone/bloc/search/search_event.dart';
import 'package:instagram_clone/bloc/search/search_state.dart';

import '../../services/db_service.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<LoadSearchMembersEvent>(_onLoadSearchMembersEvent);
  }

  Future<void> _onLoadSearchMembersEvent(
      LoadSearchMembersEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());

    var items = await DBService.searchMembers(event.keyword);

    if (items.isNotEmpty) {
      emit(SearchSuccessState(items: items));
    } else {
      emit(SearchFailureState("No data"));
    }
  }
}
