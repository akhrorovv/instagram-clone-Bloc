import 'package:bloc/bloc.dart';
import 'package:instagram_clone/bloc/feed_page/item_post/item_post_event.dart';
import 'package:instagram_clone/bloc/feed_page/item_post/item_post_state.dart';

import '../../../model/member_model.dart';
import '../../../services/db_service.dart';
import '../../../services/http_service.dart';

class ItemPostBloc extends Bloc<ItemPostEvent, ItemPostState> {
  ItemPostBloc() : super(ItemPostInitialState()) {
    on<LikePostEvent>(apiPostLike);
    on<UnlikePostEvent>(apiPostUnLike);
  }

  Future<void> apiPostLike(
      LikePostEvent event, Emitter<ItemPostState> emit) async {
    emit(ItemPostLoadingState());

    await DBService.likePost(event.post, true);

    event.post.liked = true;
    emit(LikePostState(event.post));

    var owner = await DBService.getOwner(event.post.uid);
    sendNotificationToLikedMember(owner);
  }

  void sendNotificationToLikedMember(Member someone) async {
    Member me = await DBService.loadMember();
    await Network.POST(Network.API_SEND_NOTIF, Network.notifyLike(me, someone));
  }

  Future<void> apiPostUnLike(
      UnlikePostEvent event, Emitter<ItemPostState> emit) async {
    emit(ItemPostLoadingState());

    await DBService.likePost(event.post, false);
    event.post.liked = false;
    emit(UnlikePostState(event.post));
  }
}
