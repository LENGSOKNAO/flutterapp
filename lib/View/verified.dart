import 'package:flutter/material.dart';
import 'package:flutterapp/services/auth_service.dart';

class VerifiedEmail extends StatefulWidget {
  const VerifiedEmail({super.key});

  @override
  State<VerifiedEmail> createState() => _VerifiedEmailState();
}

class _VerifiedEmailState extends State<VerifiedEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please verify your email address.',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final user = AuthService.firebase().currentUser;
                await user?.sendEmailVerification();
              },
              child: const Text('Send Verification Email'),
            ),
          ],
        ),
      ),
    );
  }
}
