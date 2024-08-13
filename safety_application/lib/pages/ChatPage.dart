import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ChatBubble.dart';
import 'ChatService.dart';

class ChatPage extends StatefulWidget {
  final String chatId;
  final String therapistName;
  final String therapistSpecialization;
  final String therapistImageUrl;

  const ChatPage({
    super.key,
    required this.chatId,
    required this.therapistName,
    required this.therapistSpecialization,
    required this.therapistImageUrl,
    required String receiverTherapistEmail,
    required String receiverTherapistId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String anonymousUserId;

  @override
  void initState() {
    super.initState();
    anonymousUserId = _auth.currentUser?.uid ?? '';
  }

  // Function to send a message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.chatId,
        anonymousUserId,
        _messageController.text,
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.therapistImageUrl),
            ),
            const SizedBox(width: 10),
            Text(widget.therapistName),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        // children: [
        //   // Expanded(
        //     // child: _buildMessageList(),
        //   ),
        //   _buildMessageInput(),
        //   const SizedBox(height: 25),
        // ],
      ),
    );
  }

  // Build message list
  // Widget _buildMessageList() {
    // return StreamBuilder<QuerySnapshot>(
      // stream: _chatService.getMessages(widget.chatId),
      // builder: (context, snapshot) {
      //   if (snapshot.hasError) {
      //     return Text('Error: ${snapshot.error}');
      //   }
      //   if (snapshot.connectionState == ConnectionState.waiting) {
      //     return const Text('Loading...');
      //   }

        // Ensure snapshot data is available and not empty
        // var docs;
        // if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        //   return const Text('No messages yet.');
        // }

        // // Build the list of messages
        // var docs;
        // return ListView(
        //   children: snapshot.data!.docs
        //       .map((document) => _buildMessageItem(document))
        //       .toList(),
        // );
      // },
  //   );
  // }

  // Build individual message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    Object anonymousUserId;
    var alignment = (data['senderId'])
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data['senderId'])
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(data['senderId']
                ? 'Anonymous'
                : widget.therapistName),
            const SizedBox(height: 5),
            ChatBubble(message: data['message']),
          ],
        ),
      ),
    );
  }

  // Build message input
  Widget _buildMessageInput() {
    var sendMessage;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Enter message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              obscureText: false,
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.send, size: 40),
          ),
        ],
      ),
    );
  }
  
  // class _messageController {
  // }
}



class DocumentSnapshot {
  data() {}
}

class QuerySnapshot {
}
