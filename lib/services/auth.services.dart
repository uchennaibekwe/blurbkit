import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:blurbkit/models/user.dart';
import 'package:blurbkit/utils/general.dart';
import 'package:http/http.dart' as http;

class Auth {
  Future createUser(User user) async {
    try {
      final response = await http.post(
        '$baseUrl/auth/users/',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "firstname": user.firstname,
            "lastname": user.lastname,
            "email": user.email,
            "phone": user.phone,
            "password": user.password,
          },
        ),
      );

      return response;
      // print(response.statusCode);
    } on SocketException {
      throw SocketException('Please check your internet connection');
    } on TimeoutException {
      throw TimeoutException('Connection Timeout!');
    } catch (e) {
      throw Exception(e);
      // print(e);
    }
  }


  Future login(User user) async {
    try {
      final response = await http.post(
        '$baseUrl/auth/login/',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "email": user.email,
            "password": user.password,
          },
        ),
      );

      return response;
      // print(response.statusCode);
    } on SocketException {
      throw SocketException('Please check your internet connection');
    } on TimeoutException {
      throw TimeoutException('Connection Timeout!');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future sendToken(email) async {
    try {
      final response = await http
          .post(
            '$baseUrl/auth/users/reset-password/',
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              "email": email,
            }),
          )
          .timeout(Duration(seconds: 60));

      return response;
    } on SocketException {
      throw SocketException('Please check your internet connection');
    } on TimeoutException {
      throw TimeoutException('Connection Timeout!');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future resetPassword(token, newPassword) async {
    try {
      final response = await http
          .post(
            '$baseUrl/auth/users/create-password/',
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              "token": token,
              "password": newPassword,
            }),
          )
          .timeout(Duration(seconds: 20));

      return response;
    } on SocketException {
      throw SocketException('Please check your internet connection');
    } on TimeoutException {
      throw TimeoutException('Connection Timeout!');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future verifyAccount(token) async {
    try {
      final response = await http
          .post(
            '$baseUrl/auth/users/verify-token/',
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              "token": token,
            }),
          )
          .timeout(Duration(seconds: 20));

      return response;
    } on SocketException {
      throw SocketException('Please check your internet connection');
    } on TimeoutException {
      throw TimeoutException('Connection Timeout!');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
