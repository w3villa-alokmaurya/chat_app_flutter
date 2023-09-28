import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;

  MessageBubble({
    required this.text,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 4.0),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SizedBox(
            width: 300,
            child: Row(
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  time,
                  style: TextStyle(fontSize: 8, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
