import 'package:bloc/bloc.dart';

import '../../../model/member_model.dart';
import '../../../services/db_service.dart';
import '../../../services/http_service.dart';
import 'item_member_event.dart';
import 'item_member_state.dart';

class ItemMemberBloc extends Bloc<ItemMemberEvent, ItemMemberState> {
  ItemMemberBloc() : super(ItemMemberInitialState()) {
    on<FollowMemberEvent>(_apiFollowMember);
    on<UnfollowMemberEvent>(_apiUnFollowMember);
  }

  void _apiUnFollowMember(
      UnfollowMemberEvent event, Emitter<ItemMemberState> emit) async {
    emit(ItemMemberLoadingState());

    await DBService.unfollowMember(event.member);

    event.member.followed = false;
    emit(UnfollowMemberState(event.member));

    await DBService.removePostsFromMyFeed(event.member);
  }

  Future<void> _apiFollowMember(
      FollowMemberEvent event, Emitter<ItemMemberState> emit) async {
    emit(ItemMemberLoadingState());

    await DBService.followMember(event.member);

    event.member.followed = true;
    emit(FollowMemberState(event.member));

    await DBService.storePostsToMyFeed(event.member);

    sendNotificationToFollowedMember(event.member);
  }

  void sendNotificationToFollowedMember(Member member) async {
    Member me = await DBService.loadMember();
    await Network.POST(
        Network.API_SEND_NOTIF, Network.paramsNotify(me, member));
  }
}
