import 'package:chat_connect_app/app/modules/navibar/domain/models/user_mode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatsRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<UserModel>> fetchRegisteredUsers() async {
    try {
      QuerySnapshot querySnapshot =
          await _firebaseFirestore.collection('users').get();
      List<UserModel> userList = querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return userList;
    } catch (e) {
      debugPrint('Error fetching users: $e');
      return [];
    }
  }
}
