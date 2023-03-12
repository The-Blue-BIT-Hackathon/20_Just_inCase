import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../screens/home_screen.dart';
import '../../screens/sign_in_screen.dart';
import '../hive_services.dart';

class SignInCheckLoader extends StatefulWidget {
  const SignInCheckLoader({Key? key}) : super(key: key);

  @override
  _SignInCheckLoaderState createState() => _SignInCheckLoaderState();
}

class _SignInCheckLoaderState extends State<SignInCheckLoader> {
  late Future<void> userCredPresent;
  late List<dynamic> userCredentials;
  late Widget redirectScreen;
  HiveServices hiveService = HiveServices();

  @override
  initState() {
    super.initState();
    userCredPresent = init();
  }

  Future<void> init() async {
    await checkForUserCredentials();
  }

  Future<void> checkForUserCredentials() async {
    try {
      // TODO: check if the user is signed in by checking the logged_user hive box values
      // checking if there exists a hive box named logged_user
      await hiveService.init();
      bool exists = await hiveService.isExists(boxName: 'logged_user');
      var data = await hiveService.openHiveBox('logged_user');

      if( data.isEmpty ) {
        redirectScreen = SignInScreen();
        return;
      }

      var details = data.toMap().values.toList()[0];

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: details["userEmail"],
          password: details["userPassword"]
      );

      if( exists ) {
        redirectScreen = HomeScreen(
          userDetails: details,
          user: credential,
        );
      }
      else {
        redirectScreen = SignInScreen();
      }
    }
    catch( e, stacktrace  ) {
      debugPrint(e.toString());
      debugPrint( stacktrace.toString() );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userCredPresent,
      builder: (context, snapshot) {
        if( snapshot.connectionState == ConnectionState.done ) {
          return redirectScreen;
        }
        else if( snapshot.hasError ) {
          return Scaffold(
            body: Container(
              alignment: Alignment.center,
              child: Text( snapshot.error.toString() ),
            ),
          );
        }
        else {
          return Scaffold(
            body: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator.adaptive(),
            ),
          );
        }
      },
    );
  }
}