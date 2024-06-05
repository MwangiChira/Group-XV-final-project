// user interface
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class SafetyApp extends StatefulWidget {
  const SafetyApp({super.key});

  @override
  _SafetyAppState createState() => _SafetyAppState();
}

class _SafetyAppState extends State<SafetyApp> {
  // Declare any necessary state variables here
  // ignore: unused_field
  bool _isEmergencyButtonPressed = false;
  String _emergencyContactNumber = "";
  String _userProfileInfo = "";
  bool _locationTrackingEnabled = false;
  final List<String> _safetyAlerts = [];

  bool get kDebugMode => assert(debugDefaultTargetPlatformOverride != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safety App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome to the Safety App!'),
            const SizedBox(height: 16.0),
            // Emergency Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isEmergencyButtonPressed = true;
                });
                // Add logic to trigger emergency actions here
                if (kDebugMode) {
                  print('Emergency button pressed!');
                }
              },
              child: const Text('Emergency'),
            ),
            const SizedBox(height: 16.0),
            // Emergency Contact Form
            TextField(
              decoration: const InputDecoration(
                labelText: 'Emergency Contact Number',
              ),
              onChanged: (value) {
                setState(() {
                  _emergencyContactNumber = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            // Safety Alerts
            ExpansionTile(
              title: const Text('Safety Alerts'),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _safetyAlerts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_safetyAlerts[index]),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _safetyAlerts.add('New Safety Alert');
                    });
                  },
                  child: const Text('Add Safety Alert'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // User Profile Information
            ExpansionTile(
              title: const Text('User Profile'),
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'User Profile Information',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _userProfileInfo = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Location Tracking
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Location Tracking'),
                Switch(
                  value: _locationTrackingEnabled,
                  onChanged: (value) {
                    setState(() {
                      _locationTrackingEnabled = value;
                    });
                    // Add logic to enable/disable location tracking
                    if (kDebugMode) {
                      print(
                          'Location tracking ${value ? 'enabled' : 'disabled'}');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
