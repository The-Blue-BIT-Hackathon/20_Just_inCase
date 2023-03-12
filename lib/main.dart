import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:job_search_app/utils/check_loaders/sign_in_check_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // redirecting the user to Sign in Check loader to check if user is signed in or not
    return const MaterialApp(
      home: SignInCheckLoader(),
    );
  }
}
