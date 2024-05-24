import 'package:bloc/bloc.dart';
import 'package:instagram_clone/bloc/feed/feed_event.dart';
import 'package:instagram_clone/bloc/feed/feed_state.dart';

import '../../services/db_service.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(FeedInitialState()) {
    on<LoadFeedPostsEvent>(_onLoadPostsEvent);
  }

  Future<void> _onLoadPostsEvent(
      LoadFeedPostsEvent event, Emitter<FeedState> emit) async {
    emit(FeedLoadingState());

    var items = await DBService.loadFeeds();

    if (items.isNotEmpty) {
      emit(FeedSuccessState(items: items));
    } else {
      emit(FeedFailureState("No data"));
    }
  }
}
