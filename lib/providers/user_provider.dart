import 'dart:convert';
import 'package:chat_app/api/api.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];

  List<User> get users => _users;

  // void updateUserList(token) async {
  //   List<User> data = await UsersApi().getData(token);
  //   _users = data;
  //   notifyListeners();
  // }
  Future<void> getData(String token) async {
    List<User> listData = [];
    try {
      final response = await http.get(
        Uri.parse(usersListUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List rawData = data['data'];
        for (var element in rawData) {
          User user = User.fromJson(element);
          listData.add(user);
        }
        _users = listData;
        notifyListeners();
      } else {
        print(response.body);
      }
    } catch (e) {
      print("Exception in Data $e");
      throw e;
    }
  }
}
