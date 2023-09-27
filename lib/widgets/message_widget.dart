import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidgetUser extends StatefulWidget {
  final String email;
  final String id;

  const MessageWidgetUser({
    super.key,
    required this.email,
    required this.id,
  });

  @override
  State<MessageWidgetUser> createState() => _MessageWidgetUserState();
}

class _MessageWidgetUserState extends State<MessageWidgetUser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          // await Provider.of<ChatProvider>(context, listen: false)
          // .getData(token, widget.id);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ChatScreen(
                  userId: widget.id,
                );
              },
            ),
          );
        },
        child: ListTile(
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.pink, Colors.orange],
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(99, 29, 27, 27),
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                ),
              ),
            ],
          ),
          title: Text(widget.email.toString()),
          subtitle: const Text('recent message overview simple'),
          trailing: GestureDetector(
            child: const Icon(Icons.camera_alt_outlined),
          ),
        ),
      ),
    );
  }
}
