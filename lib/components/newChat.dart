// ignore_for_file: camel_case_types, use_key_in_widget_constructors

import 'package:bitchat/components/myTextfield.dart';
import 'package:bitchat/home/pages/chatPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class newChat extends StatelessWidget {
  TextEditingController userinfo = TextEditingController();

  Future<void> sendNewChat(BuildContext context) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      var username = userinfo.text;
      QuerySnapshot querySnapshot =
          await users.where('username', isEqualTo: username).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Retrieve the user ID
        String userId = querySnapshot.docs.first.id;

        // Get the user data using the retrieved user ID
        DocumentSnapshot userDataSnapshot = await users.doc(userId).get();
        if (userDataSnapshot.exists) {
          Map<String, dynamic> userData =
              userDataSnapshot.data() as Map<String, dynamic>;

          // Navigate to the chat page with user data
          Navigator.pop(context);
          Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData['email'],
                receiverId: userId,
                receiverName:
                    '${userData['firstName']} ${userData['secondName']}',
                receiverProfile: userData['profile'],
              ),
            ),
          );
        } else {
          throw Exception('No user data found for user ID: $userId');
        }
      } else {
        throw Exception('No user data found for user');
      }
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error sending new chat: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        children: [
          const Text(
            "Add New Chat",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Row(
                children: [
                  Flexible(
                    child: myTextfield(
                        controller: userinfo,
                        hintText: "Enter username",
                        obsecuredText: false),
                  ),
                  IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        sendNewChat(context);
                      })
                ],
              )),
        ],
      ),
    );
  }
}
