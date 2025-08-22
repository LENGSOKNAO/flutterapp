import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/View/Login.dart';
import 'package:flutterapp/View/Register.dart';
import 'package:flutterapp/View/home.dart';
import 'package:flutterapp/View/verified.dart';
import 'package:flutterapp/constants/route.dart';
import 'package:flutterapp/firebase_options.dart';
import 'dart:developer' as devtools show log;

import 'package:flutterapp/services/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      home: MyApp(),
      routes: {
        loginRoute: (context) => Login(),
        registerRoute: (context) => Register(),
        homeRoute: (context) => HomePage(),
        verifyEmailRoute: (context) => VerifiedEmail(),
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //  in file lib/anther.dart
    // StatementAndCollections();
    // SoundNullSafely(null, 'test', 'men');
    // myEnumFunction(MyEnum.value1);
    // main2();
    // Ad();
    return Scaffold(
      body: FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;

              if (user != null) {
                if (user.isEmailVerified) {
                  print('User is not logged in');
                } else {
                  return VerifiedEmail();
                }
              } else {
                return Login();
              }
              return HomePage();
            // print(user);
            // if (emailVerified) {
            //   return const Text('Email is verified');
            // } else {
            //   Navigator.of(context).push(
            //     MaterialPageRoute(builder: (context) => VerifiedEmail()),
            //   );
            // }
            // return const Text('Welcome to the app!');
            // return Login();

            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
