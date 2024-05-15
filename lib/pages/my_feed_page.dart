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
    feedBloc = BlocProvider.of(context);

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

  // Widget itemOfPost(BuildContext context, Post post) {
  //   return BlocProvider(
  //     create: (context) => ItemPostBloc(),
  //     child: Container(
  //       color: Colors.white,
  //       child: Column(
  //         children: [
  //           const Divider(),
  //           //#user info
  //           Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 10),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(
  //                   children: [
  //                     ClipRRect(
  //                       borderRadius: BorderRadius.circular(40),
  //                       child: post.img_user.isEmpty
  //                           ? const Image(
  //                         image:
  //                         AssetImage("assets/images/ic_person.png"),
  //                         width: 40,
  //                         height: 40,
  //                         fit: BoxFit.cover,
  //                       )
  //                           : Image.network(
  //                         post.img_user,
  //                         width: 40,
  //                         height: 40,
  //                         fit: BoxFit.cover,
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       width: 10,
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           post.fullname,
  //                           style: const TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.black),
  //                         ),
  //                         const SizedBox(
  //                           height: 3,
  //                         ),
  //                         Text(
  //                           post.date,
  //                           style:
  //                           const TextStyle(fontWeight: FontWeight.normal),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 post.mine
  //                     ? IconButton(
  //                   icon: const Icon(Icons.more_horiz),
  //                   onPressed: () {
  //                     // feedBloc.dialogRemovePost(context, post);
  //                   },
  //                 )
  //                     : const SizedBox.shrink(),
  //               ],
  //             ),
  //           ),
  //           //#post image
  //           const SizedBox(height: 8),
  //           GestureDetector(
  //             onDoubleTap: () {
  //               if (!post.liked) {
  //                 // apiPostLike(post);
  //                 context.read<ItemPostBloc>().add(LikePostEvent(post));
  //               } else {
  //                 // apiPostUnLike(post);
  //                 context.read<ItemPostBloc>().add(UnlikePostEvent(post));
  //               }
  //             },
  //             child: CachedNetworkImage(
  //               width: MediaQuery.of(context).size.width,
  //               imageUrl: post.img_post,
  //               placeholder: (context, url) => const Center(
  //                 child: CircularProgressIndicator(),
  //               ),
  //               errorWidget: (context, url, error) => const Icon(Icons.error),
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //
  //           //#like share
  //           Row(
  //             children: [
  //               Row(
  //                 children: [
  //                   IconButton(
  //                     onPressed: () {
  //                       if (!post.liked) {
  //                         context.read<ItemPostBloc>().add(LikePostEvent(post));
  //                       } else {
  //                         context.read<ItemPostBloc>().add(UnlikePostEvent(post));
  //                       }
  //                     },
  //                     icon: post.liked
  //                         ? const Icon(
  //                       Icons.favorite,
  //                       color: Colors.red,
  //                     )
  //                         : const Icon(
  //                       Icons.favorite_border,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                   IconButton(
  //                     onPressed: () {},
  //                     icon: const Icon(
  //                       Icons.share,
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //
  //           //#caption
  //           Container(
  //             width: MediaQuery.of(context).size.width,
  //             margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
  //             child: RichText(
  //               softWrap: true,
  //               overflow: TextOverflow.visible,
  //               text: TextSpan(
  //                   text: post.caption,
  //                   style: const TextStyle(color: Colors.black)),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
