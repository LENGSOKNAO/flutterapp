import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/constants/route.dart';
import 'package:flutterapp/services/auth_execption.dart';
import 'package:flutterapp/services/auth_service.dart';
import 'package:flutterapp/utilities/showError.dart';
import 'package:flutterapp/firebase_options.dart';
import 'dart:developer' as devtools show log;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _email;
  late TextEditingController _pass;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _pass = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return Scaffold(
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Text(
                        'Drawer Header',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                      onTap: () {
                        // Action when Home is tapped
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                      onTap: () {
                        // Action when Settings is tapped
                      },
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                title: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.blue,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      // Action when settings icon is pressed
                    },
                  ),
                ],
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Account',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: _email,
                          enableSuggestions: true,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 20,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _pass,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final email = _email.text;
                            final pass = _pass.text;
                            try {
                              await AuthService.firebase().logIn(
                                email: email,
                                password: pass,
                              );
                              final user = AuthService.firebase().currentUser;
                              if (user?.isEmailVerified ?? false) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  homeRoute,
                                  (route) => false,
                                );
                              } else {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  homeRoute,
                                  (route) => false,
                                );
                              }
                            } on UserNotFoundAuthException {
                              await showErrorDialog(context, 'User not found');
                            } on WrongPasswordAuthException {
                              await showErrorDialog(context, 'Wrong password');
                            } on UserNotLoggedAuthException {
                              await showErrorDialog(
                                context,
                                'User not logged in',
                              );
                            } on GennericAuthException {
                              await showErrorDialog(
                                context,
                                'Authentication error',
                              );
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              registerRoute,
                              (route) => false,
                            );
                          },
                          child: Text("Not yet Registered? Sign Up"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          default:
            return Text("Loading...");
        }
      },
    );
  }
}
