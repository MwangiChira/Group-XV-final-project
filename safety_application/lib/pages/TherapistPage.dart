import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safety_application/pages/ChatPage.dart';
import 'package:uuid/uuid.dart';

class TherapistPage extends StatefulWidget {
  const TherapistPage({super.key});

  @override
  State<TherapistPage> createState() => _TherapistpageState();
}

class _TherapistpageState extends State<TherapistPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Therapist Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Listening to snapshots from the 'therapist' collection in Firestore
        stream: FirebaseFirestore.instance.collection('therapist').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;

          // Building a list of therapist items from the documents
          return ListView(
            children: docs.map((doc) => _buildTherapistListItem(doc)).toList(),
          );
        },
      ),
    );
  }

  Widget _buildTherapistListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    if (_auth.currentUser?.email != data['email']) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: data['imageUrl'] != null
                ? NetworkImage(data['imageUrl'])
                : const AssetImage('assets/images/placeholder.png')
                    as ImageProvider, //ikileta shida remove the const here and above
          ),
          title: Text(data['name'] ?? 'Unknown Name'),
          subtitle: Text(data['specialization']),
          trailing: IconButton(
            icon: Icon(Icons.chat),
            onPressed: () async {
              //generate unique chat id
              String chatId = Uuid().v4();
              await FirebaseFirestore.instance
                  .collection('chats')
                  .doc(chatId)
                  .set({
                'therapistId': data['tid'],
                'userId': _auth.currentUser!.uid,
                'startTime': FieldValue.serverTimestamp(),
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    chatId: chatId,
                    therapistName: '',
                    therapistSpecialization: '',
                    therapistImageUrl: '',
                    receiverTherapistEmail: '',
                    receiverTherapistId: '',
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
