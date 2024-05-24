import 'package:bloc/bloc.dart';

import '../../model/post_model.dart';
import '../../services/db_service.dart';
import 'likes_event.dart';
import 'likes_state.dart';

class LikesBloc extends Bloc<LikesEvent, LikesState> {
  LikesBloc() : super(InitialState()) {
    on<LoadPostEvent>(_apiLoadLikes);
  }

  List<Post> items = [];

  void _apiLoadLikes(LoadPostEvent event, Emitter<LikesState> emit) async {
    emit(LoadingState());

    var result = await DBService.loadLikes();
    items = result;

    emit(LoadPostState(items));
  }
}
