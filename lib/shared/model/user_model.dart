import 'dart:convert';

class UserModel {
  final String userName;
  final String photoUrl;
  final int score;

  UserModel({
    required this.userName,
    required this.photoUrl,
    this.score =0,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return new UserModel(
      userName: map['userName'] as String,
      photoUrl: map['photoUrl'] as String,
      score: map['score'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'userName': this.userName,
      'photoUrl': this.photoUrl,
      'score': this.score,
    } as Map<String, dynamic>;
  }

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));


}
