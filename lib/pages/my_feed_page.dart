import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/feed/feed_bloc.dart';
import '../bloc/feed/feed_event.dart';
import '../bloc/feed/feed_state.dart';
import '../model/post_model.dart';
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
    feedBloc = context.read<FeedBloc>();

    feedBloc.add(LoadFeedPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FeedLoadingState) {
          return viewOfMyFeedPage(true, []);
        }
        if (state is FeedSuccessState) {
          return viewOfMyFeedPage(false, state.items);
        }
        return viewOfMyFeedPage(false, []);
      },
    );
  }

  Widget viewOfMyFeedPage(bool isLoading, List<Post> items) {
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
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              return itemOfPost(context, items[index]);
            },
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
