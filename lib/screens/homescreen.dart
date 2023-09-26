import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/providers/theme_provider.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedValue = 'Option 1';
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (!authProvider.isLoggedIn) {
      Future.delayed(Duration.zero, () {
        // <---- This is not a widget
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    }
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(),
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Chat App',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                              onTap: () async {
                                authProvider.signOut();
                                Fluttertoast.showToast(
                                    msg: 'Logged out Successfully',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                await Future.delayed(const Duration(seconds: 1),
                                    () {
                                  Navigator.pushReplacementNamed(
                                      context, '/signin');
                                });
                              },
                              child: const Icon(
                                Icons.logout,
                                size: 24,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 8),
                            child: GestureDetector(
                              onTap: () {
                                themeProvider.setTheme();
                              },
                              child: Icon(
                                themeProvider.isDark
                                    ? Icons.dark_mode
                                    : Icons.light_mode,
                                size: 24,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: TextField(
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        hintText: 'Search',
                        fillColor: Color.fromRGBO(158, 158, 158, 0.465),
                        filled: true,
                        prefixIcon: Icon(Icons.search),
                        prefixIconColor: Colors.grey,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide.none),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [],
                  ),
                ),
                ListTile(
                  leading: const Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  trailing: GestureDetector(
                    child: const Text(
                      'Requests',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                ),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
                const MessageWidgetUser(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
