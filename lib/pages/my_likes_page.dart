import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/bloc/likes_page/likes_bloc.dart';
import 'package:instagram_clone/bloc/likes_page/likes_state.dart';
import '../bloc/likes_page/likes_event.dart';
import '../model/post_model.dart';
import '../services/db_service.dart';
import '../services/utils_service.dart';
import '../views/item_likes_post.dart';

class MyLikesPage extends StatefulWidget {
  const MyLikesPage({Key? key}) : super(key: key);

  @override
  State<MyLikesPage> createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {
  late LikesBloc likesBloc;

  @override
  void initState() {
    super.initState();

    likesBloc = BlocProvider.of<LikesBloc>(context);

    likesBloc.add(LoadPostEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Likes",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Billabong', fontSize: 30),
        ),
      ),
      body: BlocBuilder<LikesBloc, LikesState>(
        builder: (context, state) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: likesBloc.items.length,
                itemBuilder: (ctx, index) {
                  return itemOfPost(context, likesBloc.items[index]);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
