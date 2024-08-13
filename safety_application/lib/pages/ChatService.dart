// import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to send a message
  Future<void> sendMessage(
      String chatId, String senderId, String message) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'senderId': senderId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Function to get messages
  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}

class _firestore {
  static collection(String s) {}
}

mixin instance {
}

class QuerySnapshot {
}

class FieldValue {
  static serverTimestamp() {}
}

class FirebaseFirestore {
  collection(String s) {}
}
