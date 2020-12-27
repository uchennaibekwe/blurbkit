import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:blurbkit/utils/general.dart';
import 'package:http/http.dart' as http;

class BookApi {
  
  Future removeBookmark(bookId) async {
    String token = await jwtOrEmpty;
    var auth = await authUser;
    try {
      final response = await http
          .post(
            '$baseUrl/book/bookmark/',
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(<String, dynamic>{
              "user": auth['user_id'],
              "book": bookId,
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

  Future createBookmark(bookId) async {
    String token = await jwtOrEmpty;
    var auth = await authUser;
    try {
      final response = await http
          .post(
            '$baseUrl/book/bookmark/',
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(<String, dynamic>{
              "user": auth['user_id'],
              "book": bookId,
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

  Future getBookMarks() async {
    String token = await jwtOrEmpty;
    try {
      final response = await http.get(
        '$baseUrl/book/bookmark/',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
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

  Future getBookCategories({searchTerm: ''}) async {
    String token = await jwtOrEmpty;
    try {
      final response = await http.get(
        '$baseUrl/book/category/?search=$searchTerm',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
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

  Future getBooks() async {
    String token = await jwtOrEmpty;
    try {
      final response = await http.get(
        '$baseUrl/book/',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
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

  Future getRandomBooks() async {
    String token = await jwtOrEmpty;
    try {
      final response = await http.get(
        '$baseUrl/book/random_book/',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
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
}
