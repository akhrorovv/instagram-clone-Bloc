import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_page/item_member/item_member_bloc.dart';
import '../bloc/search_page/item_member/item_member_event.dart';
import '../bloc/search_page/item_member/item_member_state.dart';
import '../model/member_model.dart';

Widget itemOfMember(BuildContext context, Member member) {
  return BlocProvider(
    create: (context) => ItemMemberBloc(),
    child: BlocBuilder<ItemMemberBloc, ItemMemberState>(
      builder: (context, state) {
        return SizedBox(
          height: 90,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  border: Border.all(
                    width: 1.5,
                    color: const Color.fromRGBO(193, 53, 132, 1),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22.5),
                  child: member.img_url.isEmpty
                      ? const Image(
                    image: AssetImage("assets/images/ic_person.png"),
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  )
                      : Image.network(
                    member.img_url,
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.fullname,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      member.email,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (!member.followed) {
                        context.read<ItemMemberBloc>().add(FollowMemberEvent(member));
                      } else {
                        context.read<ItemMemberBloc>().add(UnfollowMemberEvent(member));
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: Center(
                        child: member.followed
                            ? const Text("Following")
                            : const Text("Follow"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );
}
