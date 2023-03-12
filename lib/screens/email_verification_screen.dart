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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Text(
                  "We have sent a otp on the mail ${widget.email}. Please Enter the OTP from your mail here."
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
