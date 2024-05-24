import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/search/search_bloc.dart';
import '../bloc/search/search_event.dart';
import '../bloc/search/search_state.dart';
import '../model/member_model.dart';
import '../views/item_of_member.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({Key? key}) : super(key: key);

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  late SearchBloc searchBloc;
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchBloc = BlocProvider.of<SearchBloc>(context);

    searchBloc.add(LoadSearchMembersEvent(keyword: ""));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SearchLoadingState) {
          return viewOfMySearchPage(true, []);
        }
        if (state is SearchSuccessState) {
          return viewOfMySearchPage(false, state.items);
        }
        return viewOfMySearchPage(false, []);
      },
    );
  }

  Widget viewOfMySearchPage(bool isLoading, List<Member> items) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Search",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Billabong",
            fontSize: 25,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                //#search member
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Colors.black87),
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                //#member list
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (ctx, index) {
                      return itemOfMember(context, items[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
