import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safety_application/firebase_auth.dart';
import 'package:safety_application/pages/Home_page.dart';
import 'package:safety_application/pages/ChatPage.dart';

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
          icon: Icon(Icons.arrow_back),
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
            return Center(child: CircularProgressIndicator());
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
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverTherapistEmail: data['email'],
                receiverTherapistId: data['tid'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
