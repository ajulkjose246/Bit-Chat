import 'package:bitchat/modules/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  //firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> chatingUsersId = [];

  // User Stream
  Stream<List<Map<String, dynamic>>> getUsersStream(String currentUser) {
    // Call getMessagesForCurrentUser only once and wait for it to complete
    return _firestore
        .collection('Users')
        .snapshots()
        .asyncMap((snapshot) async {
      await getMessagesForCurrentUser(
          currentUser); // Wait for this to complete before proceeding

      // Filter snapshot.docs based on chatingUsersId
      List<Map<String, dynamic>> usersData = snapshot.docs
          .where((doc) => chatingUsersId.contains(doc.id))
          .map((doc) => doc.data())
          .toList();

      // Return user data
      return usersData;
    });
  }

  Future<void> getMessagesForCurrentUser(String currentUserID) async {
    try {
      if (chatingUsersId.isEmpty) {
        // Check if chatingUsersId is empty before proceeding
        List<String> userIDs = await getAllUserIDs();
        List<String> chatroomids = [];

        for (var uid in userIDs) {
          if (uid != currentUserID) {
            chatroomids.add('${currentUserID}_$uid');
            chatroomids.add('${uid}_$currentUserID');
          }
        }
        for (var chatroomId in chatroomids) {
          QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
              .collection('chat_rooms')
              .doc(chatroomId)
              .collection('messages')
              .get();

          if (snapshot.docs.isNotEmpty) {
            // print(chatroomId.split("_"));
            chatroomId.split("_").forEach((element) async {
              if (element != currentUserID) {
                chatingUsersId.add(element);
              }
            });
          }
        }
      }
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  Future<List<String>> getAllUserIDs() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('Users').get();

      List<String> userIDs = snapshot.docs.map((doc) => doc.id).toList();

      return userIDs;
    } catch (e) {
      print('Error fetching user IDs: $e');
      return [];
    }
  }

  //send msg
  Future<void> sendMessage(String receiverId, message) async {
    //get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new msg

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    //create chat room
    List<String> ids = [currentUserId, receiverId];
    ids.sort();

    String chatRoomId = ids.join('_');

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }
  //receive msg

  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    //create a new chatroom id for the 2 users
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
