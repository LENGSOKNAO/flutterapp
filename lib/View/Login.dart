import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/firebase_options.dart';

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
                              final user = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                    email: email,
                                    password: pass,
                                  );
                              print(user);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('user not fund');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password');
                              }
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
                              '/register/',
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
