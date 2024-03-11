import 'package:bitchat/components/user_tile.dart';
import 'package:bitchat/home/pages/chatPage.dart';
import 'package:bitchat/services/auth_service.dart';
import 'package:bitchat/services/chat_services.dart';
import 'package:flutter/material.dart';

class pageChatList extends StatefulWidget {
  const pageChatList({Key? key});

  @override
  State<pageChatList> createState() => _pageChatListState();
}

class _pageChatListState extends State<pageChatList> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(_authService.getCurrentUser()!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("No users found."),
          );
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic>? userData, BuildContext context) {
    // Check if userData is null
    if (userData != null) {
      // Check if email is available in userData
      final email = userData["email"];
      if (email != null) {
        final currentUserEmail = _authService.getCurrentUser()?.email;
        if (currentUserEmail != email) {
          String fullName =
              userData['firstName']! + " " + userData['secondName']!;
          return UserTile(
            text: fullName,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiverEmail: email,
                    receiverId: userData['uid'],
                    receiverName: fullName,
                    receiverProfile: userData["profile"],
                  ),
                ),
              );
            },
            usrProfileUrl: userData["profile"],
          );
        }
      }
    }
    // Return an empty container if userData is null or email is not available
    return Container();
  }
}
