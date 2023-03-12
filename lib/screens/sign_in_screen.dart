import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_search_app/screens/home_screen.dart';
import 'package:job_search_app/screens/sign_up_screen.dart';
import 'package:job_search_app/utils/hive_services.dart';
import 'package:http/http.dart' as http;

class SignInScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  HiveServices hiveService = HiveServices();

  SignInScreen({Key? key}) : super(key: key);

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
                          "Login",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                      ),
                  ),
              ),
              
              // adding username and password text field
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
                      try{
                        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text
                        );

                        // getting user details from api
                        String url = "http://jobseekerapi.onrender.com/api/getuser/${emailController.text.trim()}";
                        http.Response response = await http.get( Uri.parse(url) );
                        
                        if( response.statusCode == 200 ) {
                          // also saving the user to hive services for next load up
                          hiveService.setValue( jsonDecode(response.body), "logged_user" );
                          FocusManager.instance.primaryFocus?.unfocus();

                          var data = await  hiveService.openHiveBox("logged_user");
                          debugPrint( data.toMap().toString() );

                          // navigating to the home Screen
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                  user: credential,
                                  userDetails: jsonDecode(response.body),
                                ),
                              )
                          );  
                        }
                        else {
                          debugPrint("Error in getting response");
                          debugPrint("Status code - ${response.statusCode}");
                        }
                      }
                      on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric( vertical: 18.0, ),
                      alignment: Alignment.center,
                      width: mediaQuery.size.width,
                      child: const Text(
                        "Login",
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
                              builder: (context) => SignUpScreen()
                          ),
                        );
                      },
                      child: const Text("Not a user yet? Sign Up"),
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
