import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationRepo {
  final _firestore = FirebaseFirestore.instance;

  Future<void> updateUserLocation(double latitude, double longitude) async {
    try {
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
        'latitude': latitude,
        'longitude': longitude,
      });
    } catch (error) {
      debugPrint('Error updating location: $error');
    }
  }
}

final locationRepo = LocationRepo();
