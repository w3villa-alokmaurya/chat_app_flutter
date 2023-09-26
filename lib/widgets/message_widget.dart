import 'package:flutter/material.dart';

class MessageWidgetUser extends StatelessWidget {
  const MessageWidgetUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
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
        title: const Text('Anuj Maurya'),
        subtitle: const Text('recent message overview simple'),
        trailing: GestureDetector(
          child: const Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }
}
