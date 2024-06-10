import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateLocation(String userId) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    await _firestore.collection('users').doc(userId).set({
      'location': {
        'latitude': position.latitude,
        'longitude': position.longitude,
      },
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Stream<DocumentSnapshot> getLocationStream(String userId) {
    return _firestore.collection('users').doc(userId).snapshots();
  }
}
