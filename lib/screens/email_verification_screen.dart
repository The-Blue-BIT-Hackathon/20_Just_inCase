import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:job_search_app/screens/setup_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  UserCredential userDetails;
  final String email;
  final String pwd;

  EmailVerificationScreen({Key? key, required this.userDetails, required this.email, required this.pwd}) : super(key: key);

  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  TextEditingController otpController = TextEditingController();
  late EmailAuth emailAuth;
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    // calling the send otp method
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if( !isEmailVerified ) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

    }
    catch( e ) {
      debugPrint( e.toString() );
    }
  }

  Future checkEmailVerified() async {
   // call after email verification
   await FirebaseAuth.instance.currentUser!.reload();

   setState(() {
     isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
   });

   if( isEmailVerified ) {
     timer?.cancel();

    // navigating to setup screen to get user data
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetupScreen(
          email: widget.email,
          password: widget.pwd,
          user: widget.userDetails,
        ),
      )
    );
   }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: mediaQuery.size.width * 0.7,
            child: Image.asset(
                "assets/images/img2.jpg"
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric( horizontal: 12.0, vertical: 12.0, ),
            child: const Text(
              "Verification Code Sent",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric( horizontal: 12.0, ),
                child: Text(
                  "We have sent an otp to ${widget.email}. Please Enter check your email to complete the verification process.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    height: 1.15,
                  ),
                ),
              )
          ),

          const SizedBox(
            height: 20,
          ),

          Container(
            height: mediaQuery.size.height * 0.4,
            alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric( horizontal: 12.0, ),
                child: const Text(
                  "You will be automatically redirected to next screen after verification..",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.15,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
          ),
        ]
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }
}
