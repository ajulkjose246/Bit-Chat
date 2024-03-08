import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  //firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //User Stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    /*
    <List<Map<String,dynamic>>>
    [
      {
        'email' : test@example.com,
        'id' : ..
      },
      {
        'email' : test@example.com,
        'id' : ..
      },
    ]
    */
    return _firestore.collection('Users').snapshots().map((snapshot) {
      //return user
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }
}
