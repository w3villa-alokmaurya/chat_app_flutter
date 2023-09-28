import 'dart:convert';

import 'package:chat_app/api/api.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  Future<void> getData(String token, String id) async {
    List<ChatMessage> listData = [];
    try {
      final response = await http.get(
        Uri.parse('$messagesList/$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List rawData = data;
        for (var element in rawData) {
          ChatMessage message = ChatMessage.fromJson(element);
          listData.add(message);
        }
        _messages = listData;
        notifyListeners();
      } else {
        print(response.body);
      }
    } catch (e) {
      print("Exception in Data $e");
      throw e;
    }
  }

  Future<void> sendMessage(
      String token, String message, String recieverId) async {
    List<ChatMessage> listData = _messages;
    try {
      final response = await http.post(
        Uri.parse(sendMessageUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {"content": message, "reciever_id": recieverId},
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Map<String, dynamic> rawdata = data;
        ChatMessage message = ChatMessage.fromJson(data);
        listData.add(message);
        _messages = listData;
        notifyListeners();
      } else {
        print('error');
      }
    } catch (e) {
      print("Exception in Data $e");
      throw e;
    }
  }
}
