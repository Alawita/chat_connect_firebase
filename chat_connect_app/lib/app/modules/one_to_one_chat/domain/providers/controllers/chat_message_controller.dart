import 'dart:io';

import 'package:chat_connect_app/app/modules/one_to_one_chat/domain/providers/state/chat_message_state.dart';
import 'package:chat_connect_app/app/modules/one_to_one_chat/domain/repo/message_repo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ChateMessageStateNotifier extends StateNotifier<ChateMessageState> {
  final MessagingRepo _messagingRepo;
  ChateMessageStateNotifier(super.state, this._messagingRepo);

  final picker = ImagePicker();

  Future<void> sendMessage(
      {required String senderId,
      required String receiverId,
      required String message}) async {
    try {
      state = state.copyWith(isLoading: true);
      await _messagingRepo
        ..sendMessage(
            senderId: senderId, recieverID: receiverId, message: message);
      state = state.copyWith(isLoading: false, message: "");
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// upload file
  Future uploadMediaFile({
    required File fileData,
    required String senderId,
    required String recieverId,
  }) async {
    /// using path package
    final fileName = basename(fileData.path);
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination);
      ref.putFile(fileData).then((snapshot) async {
        // Get download URL after upload completes
        final downloadURL = await snapshot.ref.getDownloadURL();
        // Send the downloadURL as the message to the chat
        await sendMessage(
            senderId: senderId, receiverId: recieverId, message: downloadURL);
      });
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  //Image Picker function to get image from gallery
  Future getImageFromGallery(
      {required String senderId, required String receiverId}) async {
    try {
      state = state.copyWith(isLoading: true);
      XFile? pickedFile = await picker.pickMedia();

      /// Image picker return a XFile type which needs to be converted
      /// to a File Type
      if (pickedFile != null) {
        uploadMediaFile(
          senderId: senderId,
          recieverId: receiverId,
          fileData: File(
            pickedFile.path,
          ),
        );
      }
    } catch (e) {
      state =
          state.copyWith(message: "", isLoading: false, error: e.toString());
      debugPrint(e.toString());
    }
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera(
      {required String senderId, required String receiverId}) async {
    try {
      state = state.copyWith(isLoading: true);
      final pickedFile = await picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 480,
          maxWidth: 640,
          imageQuality: 50);

      if (pickedFile != null) {
        uploadMediaFile(
          senderId: senderId,
          recieverId: receiverId,
          fileData: File(
            pickedFile.path,
          ),
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        message: "",
      );
      debugPrint(e.toString());
    }
  }

  /// clear all selected files
  void cancel() {
    state = state.copyWith(message: "");
  }
}
