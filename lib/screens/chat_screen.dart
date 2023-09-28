import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  const ChatScreen({super.key, required this.userId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String token = '';
  TextEditingController _msgcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    token = Provider.of<AuthProvider>(context, listen: false).token;

    Provider.of<ChatProvider>(context, listen: false)
        .getData(token, widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.all(8.0),
              children: [
                Consumer<ChatProvider>(
                  builder: (context, chatProvider, child) {
                    if (chatProvider.messages.isEmpty) {
                      return const Text('No messages');
                    } else {
                      return SizedBox(
                        height: 800,
                        width: double.infinity,
                        child: ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          // primary: false,
                          itemCount: chatProvider.messages.length,
                          itemBuilder: (context, index) {
                            return MessageBubble(
                              text: chatProvider.messages[index].content,
                              isMe: false,
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgcontroller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                // Text(_msgcontroller.text.toString()),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    Provider.of<ChatProvider>(context)
                        .sendMessage(token, _msgcontroller.text, widget.userId);
                    _msgcontroller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
