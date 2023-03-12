import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_search_app/screens/email_verification_screen.dart';
import 'package:job_search_app/screens/sign_in_screen.dart';
import 'package:job_search_app/utils/hive_services.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  HiveServices hiveService = HiveServices();

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric( horizontal: 12.0, ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: mediaQuery.size.width * 0.6,
                margin: const EdgeInsets.symmetric( vertical: 8.0, ),
                child: Image.asset(
                    "assets/images/img1.png"
                ),
              ),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12.0, ),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),



              Container(
                margin: const EdgeInsets.symmetric( horizontal: 12.0, ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: ("Email"),
                    prefixIcon: const Icon( Icons.alternate_email ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0,)
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Container(
                margin: const EdgeInsets.symmetric( horizontal: 12.0, ),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon( Icons.lock_open ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0,)
                      ),
                      hintText: ("Password")
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Container(
                margin: const EdgeInsets.symmetric( horizontal: 12.0, vertical: 8.0, ),
                alignment: Alignment.topCenter,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape:  MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),

                        )
                    ),
                  ),
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();

                    // User? user = await Authentication.signInWithGoogle(context: context);
                    UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                    );

                    // navigating to email verification screen
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => EmailVerificationScreen(
                              email: emailController.text,
                              pwd: passwordController.text,
                              userDetails: user,
                            )
                        )
                    ).then((value) async {
                      // you can do what you need here
                      // setState etc.
                      User? user = FirebaseAuth.instance.currentUser;
                      user!.delete();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric( vertical: 18.0, ),
                    alignment: Alignment.center,
                    width: mediaQuery.size.width,
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),

              // sign up page
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 12.0, ),
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    onTap: () {
                      // navigating to sign up screen
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()
                        ),
                      );
                    },
                    child: const Text("Already a user? Sign In!"),
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
