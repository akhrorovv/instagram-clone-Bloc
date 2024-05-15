import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/bloc/feed_page/feed_bloc.dart';
import 'package:instagram_clone/bloc/feed_page/item_post/item_post_bloc.dart';
import 'package:instagram_clone/bloc/feed_page/item_post/item_post_event.dart';
import 'package:instagram_clone/bloc/feed_page/item_post/item_post_state.dart';
import '../bloc/feed_page/feed_event.dart';
import '../bloc/feed_page/feed_state.dart';
import '../model/member_model.dart';
import '../model/post_model.dart';
import '../services/db_service.dart';
import '../services/http_service.dart';
import '../views/item_feed_post.dart';

class MyFeedPage extends StatefulWidget {
  final PageController? pageController;

  const MyFeedPage({Key? key, this.pageController}) : super(key: key);

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  late FeedBloc feedBloc;

  @override
  void initState() {
    super.initState();
    feedBloc = BlocProvider.of<FeedBloc>(context);

    feedBloc.add(FeedLoadPostEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "Instagram",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Billabong',
                fontSize: 30,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  widget.pageController!.animateToPage(
                    2,
                    duration: const Duration(microseconds: 200),
                    curve: Curves.easeIn,
                  );
                },
                icon: const Icon(Icons.camera_alt),
                color: const Color.fromRGBO(193, 53, 132, 1),
              ),
            ],
          ),
          body: Stack(
            children: [
              ListView.builder(
                itemCount: feedBloc.items.length,
                itemBuilder: (ctx, index) {
                  return itemOfPost(context, feedBloc.items[index]);
                },
              )
            ],
          ),
        );
      },
    );
  }

}
