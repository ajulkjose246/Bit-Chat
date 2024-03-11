// ignore_for_file: file_names

import 'package:bitchat/components/chat_bubble.dart';
import 'package:bitchat/components/myTextfield.dart';
import 'package:bitchat/services/auth_service.dart';
import 'package:bitchat/services/chat_services.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;
  final String receiverName;
  final String receiverProfile;
  const ChatPage(
      {super.key,
      required this.receiverEmail,
      required this.receiverId,
      required this.receiverName,
      required this.receiverProfile});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text controller
  final TextEditingController _messageController = TextEditingController();

  //chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //textfield focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //add a listener to focus
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  //scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  //send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverId, _messageController.text);
      //clear message

      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 17,
              backgroundImage: NetworkImage(widget.receiverProfile),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.receiverName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
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
    bool _userScrollingUp = false; // Track whether user is scrolling up

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollStartNotification) {
          // User starts scrolling
          _userScrollingUp = true;
        } else if (scrollNotification is ScrollEndNotification) {
          // User stops scrolling
          _userScrollingUp = false;
        }
        return false;
      },
      child: StreamBuilder(
        stream: _chatService.getMessages(widget.receiverId, senderId),
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
          return ListView.builder(
            controller: _scrollController,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              var data = doc.data() as Map<String, dynamic>;

              //current user
              bool isCurrentUser =
                  data['senderId'] == _authService.getCurrentUser()!.uid;

              // allignment
              var allignment =
                  isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

              // Scroll to bottom only if user is not scrolling up
              if (!_userScrollingUp) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    );
                  });
                });
              }

              //receiver user msg
              return Container(
                alignment: allignment,
                child: chatBubble(
                    message: data["message"], isCurrentUser: isCurrentUser),
              );
            },
          );
        },
      ),
    );
  }

  //build Message Item

  //builder msg input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: myTextfield(
              controller: _messageController,
              hintText: "Type a message",
              obsecuredText: false,
              focusNode: myFocusNode,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(left: 25),
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
