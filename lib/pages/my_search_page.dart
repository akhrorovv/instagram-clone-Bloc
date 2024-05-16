import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/search_page/search_bloc.dart';
import '../bloc/search_page/search_event.dart';
import '../bloc/search_page/search_state.dart';
import '../views/item_search_member.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({Key? key}) : super(key: key);

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  bool isLoading = false;
  late SearchBloc searchBloc;

  @override
  void initState() {
    super.initState();
    searchBloc = BlocProvider.of<SearchBloc>(context);

    searchBloc.add(SearchMembersEvent(''));
  }

  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Stack(
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
                        controller: searchBloc.searchController,
                        decoration: const InputDecoration(
                            hintText: "Search",
                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(fontSize: 15, color: Colors.grey),
                            icon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            )),
                      ),
                    ),

                    //#member list
                    Expanded(
                      child: ListView.builder(
                        itemCount: searchBloc.items.length,
                        itemBuilder: (ctx, index) {
                          return itemOfMember(context, searchBloc.items[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
