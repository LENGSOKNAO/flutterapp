import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/View/Login.dart';
import 'package:flutterapp/View/Register.dart';
import 'package:flutterapp/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: MyApp(),
      routes: {
        '/login/': (context) => Login(),
        '/register/': (context) => Register(),
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
          'Flutter Course',
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
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // final user = FirebaseAuth.instance.currentUser;
              // final emailVerified = user?.emailVerified ?? false;
              // print(user);
              // if (emailVerified) {
              //   return const Text('Email is verified');
              // } else {
              //   Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => VerifiedEmail()),
              //   );
              // }
              // return const Text('Welcome to the app!');
              return Login();
            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
