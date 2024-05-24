import 'package:bloc/bloc.dart';
import 'package:instagram_clone/bloc/profile/profile_event.dart';
import 'package:instagram_clone/bloc/profile/profile_state.dart';
import '../../model/post_model.dart';
import '../../services/db_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  List<Post> items = [];
  int count_posts = 0;

  ProfileBloc() : super(ProfileInitialState()) {
    on<LoadProfilePostsEvent>(_onLoadProfilePostsEvent);
  }

  Future<void> _onLoadProfilePostsEvent(LoadProfilePostsEvent event, Emitter<ProfileState> emit) async {
    var result = await DBService.loadPosts();
    event.items = result;
    count_posts = event.items.length;

    emit(ProfileLoadPostsState());
  }
}
