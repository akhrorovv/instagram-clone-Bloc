import 'package:bloc/bloc.dart';
import 'package:instagram_clone/bloc/feed_event.dart';
import 'package:instagram_clone/bloc/feed_state.dart';

import '../model/post_model.dart';
import '../services/db_service.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  bool isLoading = false;
  List<Post> items = [];

  FeedBloc() : super(FeedInitialState()) {
    on<LoadPostListEvent>(_onLoadPostListEvent);
  }

  Future<void> _onLoadPostListEvent(
      LoadPostListEvent event, Emitter<FeedState> emit) async {
    emit(FeedLoadingState());

    DBService.loadFeeds().then((posts) => {items = posts});
  }
}
