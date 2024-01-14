import 'package:chat_connect_app/app/modules/navibar/domain/models/user_mode.dart';
import 'package:chat_connect_app/app/modules/navibar/domain/provider/repo/chat_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatsRepositoryProvider = Provider((ref) => ChatsRepo());

final usersProvider = FutureProvider.autoDispose<List<UserModel>>((ref) async {
  final chatsRepo = ref.watch(chatsRepositoryProvider);
  debugPrint("*******");
  try {
    final userList = await chatsRepo.fetchRegisteredUsers();
    return userList;
  } catch (e) {
    debugPrint('Error fetching users: $e');
    return [];
  }
});
