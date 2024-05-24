import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/feed/feed_bloc.dart';
import '../bloc/feed/like_post/like_post_bloc.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import '../bloc/likes/likes_bloc.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/search/follow_member/follow_member_bloc.dart';
import '../bloc/search/search_bloc.dart';
import '../bloc/upload/image_picker_bloc.dart';
import '../bloc/upload/upload_bloc.dart';
import '../services/log_service.dart';
import 'my_feed_page.dart';
import 'my_likes_page.dart';
import 'my_profile_page.dart';
import 'my_search_page.dart';
import 'my_upload_page.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    homeBloc = context.read<HomeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            LogService.i(state.currentIndex.toString());
          },
          builder: (context, state) {
            return Scaffold(
              body: PageView(
                controller: _pageController,
                children: [
                  MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => FeedBloc(),
                      ),
                      BlocProvider(
                        create: (context) => LikePostBloc(),
                      ),
                    ],
                    child: MyFeedPage(pageController: _pageController),
                  ),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => SearchBloc(),
                      ),
                      BlocProvider(
                        create: (context) => FollowMemberBloc(),
                      ),
                    ],
                    child: const MySearchPage(),
                  ),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => UploadBloc(),
                      ),
                      BlocProvider(
                        create: (context) => ImagePickerBloc(),
                      ),
                    ],
                    child: MyUploadPage(pageController: _pageController),
                  ),
                  BlocProvider(
                    create: (context) => LikesBloc(),
                    child: const MyLikesPage(),
                  ),
                  BlocProvider(
                    create: (context) => ProfileBloc(),
                    child: const MyProfilePage(),
                  ),
                ],
                onPageChanged: (int index) {
                  homeBloc.add(PageViewEvent(currentIndex: index));
                },
              ),
              bottomNavigationBar: CupertinoTabBar(
                onTap: (int index) {
                  homeBloc.add(BottomNavEvent(currentIndex: index));
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                  );
                },
                currentIndex: state.currentIndex,
                activeColor: const Color.fromRGBO(193, 53, 132, 1),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home, size: 32),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search, size: 32),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_box, size: 32),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite, size: 32),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle, size: 32),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
