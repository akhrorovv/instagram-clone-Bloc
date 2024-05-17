import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/bloc/likes_page/item_post/item_post_event.dart';
import 'package:instagram_clone/bloc/likes_page/item_post/item_post_state.dart';
import 'package:instagram_clone/bloc/likes_page/likes_bloc.dart';
import 'package:instagram_clone/bloc/likes_page/likes_event.dart';

import '../../../services/db_service.dart';
import '../../../services/utils_service.dart';

class ItemPostBloc extends Bloc<ItemPostEvent, ItemPostState> {
  ItemPostBloc() : super(ItemPostInitialState()) {
    on<UnlikePostEvent>(apiPostUnLike);
    on<RemovePostEvent>(dialogRemovePost);
  }

  Future<void> apiPostUnLike(UnlikePostEvent event, Emitter<ItemPostState> emit) async {
    emit(ItemPostLoadingState());

    await DBService.likePost(event.post, false);

    emit(UnlikePostState(event.post));
  }

  Future<void> dialogRemovePost(
      RemovePostEvent event, Emitter<ItemPostState> emit) async {
    var result = await Utils.dialogCommon(
      event.context,
      "Instagram",
      "Do you want to delete this post?",
      false,
    );

    if (result) {
      emit(ItemPostLoadingState());

      DBService.removePost(event.post).then(
              (value) => {event.context.read<LikesBloc>().add(LoadPostEvent())});
    }
  }
}