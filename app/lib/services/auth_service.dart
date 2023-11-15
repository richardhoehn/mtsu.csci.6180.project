import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:app/util/config.dart';

class AuthService {
  final dio = Dio();
  bool isLoggedIn = false;
  String error = '';

  Future<void> login({required String email, required String password}) async {
    final response = await dio.post(
      '${Config.domain.scheme}://${Config.domain.host}/users/auth',
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
      throw Exception(response.data);
    }

    return;
  }
}
