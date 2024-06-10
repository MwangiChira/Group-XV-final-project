// Importing necessary packages for the app
import 'package:flutter/material.dart'; // Flutter's material design package for UI components
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Google Maps Flutter package for displaying maps
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore package for database interactions
import 'location_service.dart'; // Custom location service for handling location updates

// A StatefulWidget that represents the map screen
class MapScreen extends StatefulWidget {
  final String userId; // A final variable to hold the user ID

  // Constructor to initialize the userId
  const MapScreen({super.key, required this.userId});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState(); // Creating the state for this StatefulWidget
}

// The state class for MapScreen
class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController; // Declaring a variable to control the Google Map
  final Set<Marker> _markers = {}; // Creating a set to hold map markers

  @override
  void initState() {
    super.initState(); // Calling the superclass's initState method
    _listenToLocationUpdates(); // Starting to listen to location updates when the widget initializes
  }

  // Method to listen to real-time location updates from Firestore
  void _listenToLocationUpdates() {
    LocationService().getLocationStream(widget.userId).listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) { // Checking if the snapshot contains data
        var data = snapshot.data() as Map<String, dynamic>; // Extracting data from the snapshot
        var location = data['location']; // Getting the location field from the data
        var latitude = location['latitude']; // Extracting latitude from the location data
        var longitude = location['longitude']; // Extracting longitude from the location data

        // Adding a marker to the map at the user's current location
        setState(() {
          _markers.add(
            Marker(
              markerId: const MarkerId('userLocation'), // Unique ID for the marker
              position: LatLng(latitude, longitude), // Position of the marker
            ),
          );
        });

        // Moving the camera to the user's current location
        _mapController.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(latitude, longitude),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Location Sharing'), // Setting the title of the app bar
      ),
      body: GoogleMap(
        // Initializing the Google Map widget
        onMapCreated: (controller) {
          _mapController = controller; // Assigning the map controller
        },
        initialCameraPosition: const CameraPosition(
          // Setting the initial camera position to coordinates (0, 0)
          target: LatLng(0, 0),
          zoom: 14.0, // Setting the initial zoom level
        ),
        markers: _markers, // Adding markers to the map
      ),
      floatingActionButton: FloatingActionButton(
        // Adding a floating action button to update the user's location
        onPressed: () => LocationService().updateLocation(widget.userId),
        child: const Icon(Icons.my_location), // Setting the icon of the button
      ),
    );
  }
}
