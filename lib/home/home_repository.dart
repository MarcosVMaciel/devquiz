import 'dart:convert';

import 'package:devquiz/shared/model/quiz_model.dart';
import 'package:devquiz/shared/model/user_model.dart';
import 'package:flutter/services.dart';

class HomeRepository {
  Future<UserModel> getUser() async {
    await Future.delayed(Duration(seconds: 2));
    final response = await rootBundle.loadString("database/user.json");
    final user = UserModel.fromJson(response);
    return user;
  }
  Future<List<QuizModel>> getQuizzes() async {
    await Future.delayed(Duration(seconds: 2));
    final response = await rootBundle.loadString("database/quizzes.json");
    final list = jsonDecode(response) as List;
    final quizzes = list.map((e) => QuizModel.fromMap(e)).toList();
    return quizzes;
  }
}