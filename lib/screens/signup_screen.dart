// signup_screen.dart
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(98, 61, 95, 46),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Signup',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                // key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 400,
                        height: 45,
                        child: TextFormField(
                          onChanged: (value) => authProvider.setEmail(value),
                          validator: (value) {
                            return authProvider.isEmailValid
                                ? null
                                : 'Enter a valid email address';
                          },
                          decoration: InputDecoration(
                            errorBorder: authProvider.errorBodrer,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: authProvider.isEmailValid
                                ? authProvider.successBorder
                                : authProvider.errorBodrer,
                            // focusColor: Colors.white,
                            errorStyle: const TextStyle(
                                fontSize: 10, color: Colors.black),
                            label: const Text(
                              'Email',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 400,
                        height: 45,
                        child: TextFormField(
                          onChanged: (value) => authProvider.setPassword(value),
                          obscureText: true,
                          decoration: InputDecoration(
                            errorBorder: authProvider.errorBodrer,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: authProvider.isPasswordValid
                                ? authProvider.successBorder
                                : authProvider.errorBodrer,
                            // focusColor: Colors.white,
                            errorStyle: const TextStyle(
                                fontSize: 10, color: Colors.black),
                            label: const Text(
                              'Password',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          validator: (_) {
                            return authProvider.isPasswordValid
                                ? null
                                : 'Password must be at least 6 characters long';
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(150, 40)),
                        onPressed: () async {
                          if (authProvider.isEmailValid &&
                              authProvider.isPasswordValid) {
                            try {
                              User? user = await authProvider.signup(
                                authProvider.email.toString(),
                                authProvider.password.toString(),
                              );

                              if (user != null) {
                                Fluttertoast.showToast(
                                    msg: 'User created Successfully',
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
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Please try again',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            } catch (e) {
                              Fluttertoast.showToast(
                                  msg: e.toString(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Email and password is not valid. Please Fill all the fields",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already Have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/signin');
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
