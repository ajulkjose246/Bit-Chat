// ignore_for_file: file_names

import 'package:bitchat/components/user_tile.dart';
import 'package:bitchat/home/pages/chatPage.dart';
import 'package:bitchat/services/auth_service.dart';
import 'package:bitchat/services/chat_services.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class pageChatList extends StatefulWidget {
  const pageChatList({super.key});

  @override
  State<pageChatList> createState() => _pageChatListState();
}

// ignore: camel_case_types
class _pageChatListState extends State<pageChatList> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return _buildUserList();
  }

  //builds the user list
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text("Loading"),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("No users found."),
          );
        }
        // ignore: avoid_print
        print("Snapshot data: ${snapshot.data}");
        //list
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all the users except the current logged in user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverEmail: userData['email'],
                  receiverId: userData['uid'],
                ),
              ));
        },
      );
    } else {
      return Container();
    }
  }
}
