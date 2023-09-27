// auth_provider.dart

import 'dart:convert';

import 'package:chat_app/api/api.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  dynamic _isLoggedIn;
  bool get isLoggedIn => _isLoggedIn;

  String _email = '';
  String _password = '';
  String _token = '';
  String get token => _token;

  User? _user; // Store the signed-up user data

  User? get user => _user;

  final successBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.green, width: 1),
    borderRadius: BorderRadius.circular(10),
  );
  final errorBodrer = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.red,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10),
  );

  String? get email => _email;
  String? get password => _password;

  bool get isEmailValid => validateEmail(_email) == null;
  bool get isPasswordValid => validatePassword(_password) == null;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  String? validateEmail(String value) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  Future<User?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(userLoginUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'user': {
            'email': email,
            'password': password,
          }
        },
      ),
    );
    final Map<String, dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      _user = User(email: email, id: data['data']['id'].toString());
      await setLoggedInStatus(true);
      // _isLoggedIn = true;
      notifyListeners();
      return _user;
    } else {
      await setLoggedInStatus(false);
      // _isLoggedIn = false;

      notifyListeners();
      throw Exception('Email or password is wrong');
    }
  }

  Future<void> setLoggedInStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<void> getLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await Future.delayed(const Duration(seconds: 2));
    _isLoggedIn = await prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }

  void signOut() async {
    // Add logic to sign out if needed
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await setLoggedInStatus(false);
    _isLoggedIn = await prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
    // notifyListeners();
  }

  Future<User?> signup(String email, String password) async {
    final response = await http.post(
      Uri.parse(createUserUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'user': {
            'email': email,
            'password': password,
          }
        },
      ),
    );
    final Map<String, dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      _user = User(email: email, id: data['data']['id'].toString());
      return _user;
    } else {
      throw Exception(data['status']['message']);
    }
  }
}
