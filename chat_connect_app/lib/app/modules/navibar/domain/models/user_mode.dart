// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/* 
*/
class UserModel {
  final String username;
  final String email;
  final String userID;
  final String userLocation;
  UserModel({
    required this.username,
    required this.email,
    required this.userID,
    required this.userLocation,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? userID,
    String? userLocation,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      userID: userID ?? this.userID,
      userLocation: userLocation ?? this.userLocation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'userID': userID,
      'userLocation': userLocation,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      userID: map['userID'] as String,
      userLocation: map['userLocation'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, userID: $userID, userLocation: $userLocation)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.email == email &&
        other.userID == userID &&
        other.userLocation == userLocation;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        email.hashCode ^
        userID.hashCode ^
        userLocation.hashCode;
  }
}
