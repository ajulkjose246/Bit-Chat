import 'package:bitchat/components/chat_bubble.dart';
import 'package:bitchat/components/myTextfield.dart';
import 'package:bitchat/services/auth_service.dart';
import 'package:bitchat/services/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverId;
  ChatPage({super.key, required this.receiverEmail, required this.receiverId});

  //text controller
  final TextEditingController _messageController = TextEditingController();

  //chat and auth services

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //send message

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverId, _messageController.text);
      //clear message

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(233, 229, 225, 1),
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          //display all msg
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput()
        ],
      ),
    );
  }

  // build Message List
  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverId, senderId),
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
            child: CircularProgressIndicator(),
          );
        }

        //return list

        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }
  //build Message Item

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //current user
    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;

    // allignment
    var allignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    //reciver user msg

    return Container(
      alignment: allignment,
      child: chatBubble(message: data["message"], isCurrentUser: isCurrentUser),
    );
  }

  //builder msg input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Expanded(
            child: myTextfield(
                controller: _messageController,
                hintText: "Type a message",
                obsecuredText: false),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25, left: 25),
            child: IconButton(
                onPressed: sendMessage,
                color: Colors.white,
                icon: const Icon(
                  Icons.arrow_upward,
                )),
          )
        ],
      ),
    );
  }
}