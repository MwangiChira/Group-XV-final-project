import 'dart:html';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PanicButton extends StatefulWidget {
  @override
  _PanicButtonState createState() => _PanicButtonState();
}

class _PanicButtonState extends State<PanicButton> {
  bool _isLoading = false;

  Future<void> _sendPanicAlert() async {
    setState(() {
      _isLoading = true;
    });

    // Request location permission
    PermissionStatus permission = await Permission.location.request();
    if (permission != PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permission denied')),
      );
      return;
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Send location to emergency contacts
    await _sendLocationToContacts(position);

    // Find nearby emergency helplines
    await _findNearbyHelplines(position);

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _sendLocationToContacts(Position position) async {
    // Fetch emergency contacts from Firestore
    CollectionReference contactsRef =
        FirebaseFirestore.instance.collection('contacts');
    QuerySnapshot contactsSnapshot = await contactsRef.get();
    List<QueryDocumentSnapshot> contacts = contactsSnapshot.docs;

    for (var contact in contacts) {
      String phoneNumber = contact['phone'];
      // Send SMS (implement your preferred SMS API)
      print('Sending location to $phoneNumber: ${position.latitude}, ${position.longitude}');
      // Implement actual SMS sending logic here
    }
  }

  Future<void> _findNearbyHelplines(Position position) async {
    final String apiKey = 'YOUR_GOOGLE_API_KEY';
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${position.latitude},${position.longitude}&radius=5000&type=police|hospital&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> results = data['results'];
      results.forEach((result) {
        print('Found helpline: ${result['name']}');
      });
    } else {
      throw Exception('Failed to load nearby helplines');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _sendPanicAlert,
      child: _isLoading ? CircularProgressIndicator() : Text('Panic Button'),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        onPrimary: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    );
  }
}
