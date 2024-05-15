import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../model/post_model.dart';
import '../../services/db_service.dart';
import '../../services/utils_service.dart';
import 'feed_event.dart';
import 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  bool isLoading = false;
  List<Post> items = [];

  FeedBloc() : super(FeedInitialState()) {
    on<FeedLoadPostEvent>(_apiLoadFeeds);
  }

  Future<void> _apiLoadFeeds(FeedLoadPostEvent event, Emitter<FeedState> emit) async {
    emit(FeedInitialState());

    var result = await DBService.loadFeeds();
    items = result;

    emit(FeedLoadPostState(items));
  }

  dialogRemovePost(BuildContext context, Post post) async {
    var result = await Utils.dialogCommon(
      context,
      "Instagram",
      "Do you want to delete this post?",
      false,
    );

    if (result) {
      emit(FeedLoadingState());

      DBService.removePost(post).then((value) => {
            add(FeedLoadPostEvent()),
          });
    }
  }

}
