import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/likes/likes_bloc.dart';
import '../bloc/likes/likes_event.dart';
import '../bloc/likes/likes_state.dart';
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
