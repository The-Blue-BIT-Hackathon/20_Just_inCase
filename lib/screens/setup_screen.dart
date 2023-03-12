import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_search_app/screens/home_screen.dart';
import 'package:job_search_app/utils/Utils.dart';

import '../utils/hive_services.dart';

import 'package:http/http.dart' as http;


class SetupScreen extends StatefulWidget {
  final UserCredential user;
  final String email;
  final String password;
  HiveServices hiveServices = HiveServices();

  SetupScreen({Key? key, required this.user, required this.email, required this.password}) : super(key: key);

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  // for sending requests
  final requestHeaders = {
    "Content-Type": "application/json"
  };

  Map<String, String> requestBody = {};
  late Uri url;

  bool userName = false;
  bool phoneError = false;
  bool cityError = false;
  bool stateError = false;
  bool countryError = false;
  bool githubError = false;
  bool leetcodeError = false;
  bool codechefError = false;

  String userNameErrorText = "Name cannot be empty";
  String phoneErrorText = "Phone cannot be empty";
  String cityErrorText = "City cannot be empty";
  String stateErrorText = "State cannot be empty";
  String countryErrorText = "Country cannot be empty";
  String githubErrorText = "GitHub Link cannot be empty";
  String leetcodeErrorText = "LeetCode Link cannot be empty";
  String codechefErrorText = "CodeChef cannot be empty";

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController githubController = TextEditingController();
  final TextEditingController leetcodeController = TextEditingController();
  final TextEditingController codechefController = TextEditingController();

  final HiveServices _hiveService = HiveServices();

  void signUpUser( MediaQueryData mediaQuery ) async {
    try{
      showDialog(
          context: context,
          builder: (context) => Container(
            color: Colors.white12,
            alignment: Alignment.center,
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>( Colors.grey.shade800),
              strokeWidth: 5,
            ),
          )
      );

      // checking if userEmail is valid
      if( userNameController.text.isEmpty ) {
        setState(() {
          userNameErrorText = "Name cannot be empty";
          userName = true;
        });
      }
      else {
        setState(() {
          userName = false;
        });
      }

      // validating store name
      if( phoneController.text.isEmpty ) {
        setState(() {
          phoneError = true;
        });
      }
      else if( !Utils.isNumeric( phoneController.text ) ) {
        setState(() {
          phoneError = true;
        });
      }
      else if( phoneController.text.length != 10 ) {
        setState(() {
          phoneErrorText = "Phone Number must be 10 digit";
          phoneError = true;
        });
      }
      else {
        setState(() {
          phoneError = false;
        });
      }

      // validating store address
      if( cityController.text.isEmpty ) {
        setState(() {
          cityError = true;
        });
      }
      else {
        setState(() {
          cityError = false;
        });
      }

      // validating gst number
      if ( stateController.text.isEmpty ) {
        setState(() {
          stateErrorText = "City cannot be empty";
          stateError = true;
        });
      }
      else {
        setState(() {
          stateError = false;
        });
      }

      // validating password
      if( countryController.text.isEmpty ) {
        setState(() {
          countryErrorText = "Country cannot be empty";
          countryError = true;
        });
      }
      else {
        setState(() {
          countryError = false;
        });
      }

      if( githubController.text.isEmpty ) {
        setState(() {
          githubError = true;
        });
      }
      else {
        setState(() {
          githubError = false;
        });
      }

      if( leetcodeController.text.isEmpty ) {
        setState(() {
          leetcodeError = true;
        });
      }
      else {
        setState(() {
          leetcodeError = false;
        });
      }


      if( codechefController.text.isEmpty ) {
        setState(() {
          codechefError= true;
        });
      }
      else {
        setState(() {
          codechefError = false;
        });
      }

      // returning if any of the above condition is false

      if( userName || phoneError || cityError || stateError || countryError || leetcodeError || githubError || codechefError ) {
        Navigator.of(context).pop();
        return;
      }

      // sending request to register the user
      String signUp = "https://jobseekerapi.onrender.com/api/createuser";
      Uri url = Uri.parse( signUp );

      requestBody = {
        "name" : userNameController.text,
        "email" : widget.email,
        "password" : widget.password,
        "phone" : phoneController.text,
        "city" : cityController.text,
        "state" : stateController.text,
        "country" : countryController.text,
        "github": githubController.text,
        "leetcode" : leetcodeController.text,
        "codechef" : codechefController.text,
      };

      http.Response response = await http.post(
          url,
          body: json.encode(requestBody),
          headers: requestHeaders,
      );

      debugPrint( requestBody.toString() );

      if( response.statusCode == 200) {
        final responseBody = jsonDecode( response.body );

        // saving the user information in logged_user box
        responseBody['userEmail'] = responseBody['email'];
        responseBody['userPassword'] = responseBody['password'];

        _hiveService.setValue( responseBody, "logged_user" );
      }
      else {
        debugPrint("Unable to get response");
        debugPrint("response code - ${response.statusCode}" );
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => HomeScreen(
              user: widget.user,
              userDetails: requestBody,
            )
        ),
      );
    }
    catch( e, s ) {
      debugPrint( e.toString() );
      debugPrint( s.toString() );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // setting the value for media Query
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
              pinned: false,
              floating: true,
              forceElevated: innerBoxIsScrolled,
            )],
            body: Container(
              width: mediaQuery.size.width,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only( top:10.0, bottom: 5.0),
                      width: mediaQuery.size.width * 0.92,
                      child: Text(
                        "Setting up",
                        style: TextStyle(
                            fontSize: 40 * mediaQuery.textScaleFactor,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                      width: mediaQuery.size.width * 0.92,
                      child: Text(
                        "Great! Just a few more details and we are ready to go!",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),

                    // Name text field
                    SizedBox(
                      width: mediaQuery.size.width * 0.92,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            height: 30,
                            child: const Text(
                              "Name",
                              style: TextStyle(
                                color: Colors.black ,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              " *",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20 * mediaQuery.textScaleFactor
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: mediaQuery.size.width * 0.92,
                      height: mediaQuery.size.height * 0.065,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 10,
                              offset: const Offset(2, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: TextField(
                        onChanged: (value) {
                          if( userName ) {
                            setState(() {
                              userName = false;
                            });
                          }
                        },
                        controller: userNameController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: userName ? OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ) : OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(76, 215, 195, 1.0),
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            hintText: "Enter you contact email address",
                            hintStyle: TextStyle(
                              fontSize: 14.0 * mediaQuery.textScaleFactor,
                              color: Colors.grey,
                            )
                        ),
                      ),
                    ),
                    if( userName  )
                      Container(
                        padding: const EdgeInsets.only(top:4.0, left: 8.0),
                        width: mediaQuery.size.width * 0.92,
                        child: Text(
                          userNameErrorText,
                          style: TextStyle(
                              fontSize: 12 * mediaQuery.textScaleFactor,
                              color: Colors.red
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Phone text field
                    SizedBox(
                      width: mediaQuery.size.width * 0.92,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            height: 30,
                            child: const Text(
                              "Phone",
                              style: TextStyle(
                                color: Colors.black ,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              " *",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20 * mediaQuery.textScaleFactor
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: mediaQuery.size.width * 0.92,
                      height: mediaQuery.size.height * 0.065,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 10,
                              offset: const Offset(2, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: TextField(
                        onChanged: (value) {
                          if( phoneError ) {
                            setState(() {
                              phoneError = false;
                            });
                          }
                        },
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: phoneError ? OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ) : OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(76, 215, 195, 1.0),
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            hintText: "Enter your Phone Number",
                            hintStyle: TextStyle(
                              fontSize: 14.0 * mediaQuery.textScaleFactor,
                              color: Colors.grey,
                            )
                        ),
                      ),
                    ),
                    if( phoneError )
                      Container(
                        padding: const EdgeInsets.only(top:4.0, left: 8.0),
                        width: mediaQuery.size.width * 0.92,
                        child: Text(
                          phoneErrorText,
                          style: TextStyle(
                              fontSize: 12 * mediaQuery.textScaleFactor,
                              color: Colors.red
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),

                    // City text field
                    SizedBox(
                      width: mediaQuery.size.width * 0.92,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            height: 30,
                            child: const Text(
                              "City",
                              style: TextStyle(
                                color: Colors.black ,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              " *",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20 * mediaQuery.textScaleFactor
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: mediaQuery.size.width * 0.92,
                      height: mediaQuery.size.height * 0.065,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 10,
                              offset: const Offset(2, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: TextField(
                        onChanged: (value) {
                          if( cityError ) {
                            setState(() {
                              cityError = false;
                            });
                          }
                        },
                        controller: cityController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: cityError ? OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ) : OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(76, 215, 195, 1.0),
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            hintText: "Enter your City",
                            hintStyle: TextStyle(
                              fontSize: 14.0 * mediaQuery.textScaleFactor,
                              color: Colors.grey,
                            )
                        ),
                      ),
                    ),
                    if( cityError )
                      Container(
                        padding: const EdgeInsets.only(top:4.0, left: 8.0),
                        width: mediaQuery.size.width * 0.92,
                        child: Text(
                          cityErrorText,
                          style: TextStyle(
                              fontSize: 12 * mediaQuery.textScaleFactor,
                              color: Colors.red
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),

                    // State text field
                    SizedBox(
                      width: mediaQuery.size.width * 0.92,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            height: 30,
                            child: const Text(
                              "State",
                              style: TextStyle(
                                color: Colors.black ,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              " *",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20 * mediaQuery.textScaleFactor
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: mediaQuery.size.width * 0.92,
                      height: mediaQuery.size.height * 0.065,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 10,
                              offset: const Offset(2, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: TextField(
                        onChanged: (value) {
                          if( stateError ) {
                            setState(() {
                              stateError = false;
                            });
                          }
                        },
                        controller: stateController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: stateError ? OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ) : OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(76, 215, 195, 1.0),
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            hintText: "Enter your State",
                            hintStyle: TextStyle(
                              fontSize: 14.0 * mediaQuery.textScaleFactor,
                              color: Colors.grey,
                            )
                        ),
                      ),
                    ),
                    if( stateError )
                      Container(
                        padding: const EdgeInsets.only(top:4.0, left: 8.0),
                        width: mediaQuery.size.width * 0.92,
                        child: Text(
                          stateErrorText,
                          style: TextStyle(
                              fontSize: 12 * mediaQuery.textScaleFactor,
                              color: Colors.red
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Country text field
                    SizedBox(
                      width: mediaQuery.size.width * 0.92,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            height: 30,
                            child: const Text(
                              "Country",
                              style: TextStyle(
                                color: Colors.black ,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              " *",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20 * mediaQuery.textScaleFactor
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: mediaQuery.size.width * 0.92,
                      height: mediaQuery.size.height * 0.065,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 10,
                              offset: const Offset(2, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: TextField(
                        onChanged: (value) {
                          if( countryError ) {
                            setState(() {
                              countryError = false;
                            });
                          }
                        },
                        controller: countryController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: countryError ? OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ) : OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(76, 215, 195, 1.0),
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            hintText: "Enter your Country",
                            hintStyle: TextStyle(
                              fontSize: 14.0 * mediaQuery.textScaleFactor,
                              color: Colors.grey,
                            )
                        ),
                      ),
                    ),
                    if( countryError )
                      Container(
                        padding: const EdgeInsets.only(top:4.0, left: 8.0),
                        width: mediaQuery.size.width * 0.92,
                        child: Text(
                          countryErrorText,
                          style: TextStyle(
                              fontSize: 12 * mediaQuery.textScaleFactor,
                              color: Colors.red
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),

                    // github text field
                    SizedBox(
                      width: mediaQuery.size.width * 0.92,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            height: 30,
                            child: const Text(
                              "Github",
                              style: TextStyle(
                                color: Colors.black ,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              " *",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20 * mediaQuery.textScaleFactor
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: mediaQuery.size.width * 0.92,
                      height: mediaQuery.size.height * 0.065,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 10,
                              offset: const Offset(2, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: TextField(
                        onChanged: (value) {
                          if( githubError ) {
                            setState(() {
                              githubError = false;
                            });
                          }
                        },
                        controller: githubController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: githubError ? OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ) : OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(76, 215, 195, 1.0),
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            hintText: "Enter your Github Link",
                            hintStyle: TextStyle(
                              fontSize: 14.0 * mediaQuery.textScaleFactor,
                              color: Colors.grey,
                            )
                        ),
                      ),
                    ),
                    if( githubError )
                      Container(
                        padding: const EdgeInsets.only(top:4.0, left: 8.0),
                        width: mediaQuery.size.width * 0.92,
                        child: Text(
                          githubErrorText,
                          style: TextStyle(
                              fontSize: 12 * mediaQuery.textScaleFactor,
                              color: Colors.red
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),

                    // leetcode text field
                    SizedBox(
                      width: mediaQuery.size.width * 0.92,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            height: 30,
                            child: const Text(
                              "Leetcode Link",
                              style: TextStyle(
                                color: Colors.black ,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              " *",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20 * mediaQuery.textScaleFactor
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: mediaQuery.size.width * 0.92,
                      height: mediaQuery.size.height * 0.065,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 10,
                              offset: const Offset(2, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: TextField(
                        onChanged: (value) {
                          if( leetcodeError ) {
                            setState(() {
                              leetcodeError = false;
                            });
                          }
                        },
                        controller: leetcodeController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: leetcodeError ? OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ) : OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(76, 215, 195, 1.0),
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            hintText: "Enter your Leetcode Link",
                            hintStyle: TextStyle(
                              fontSize: 14.0 * mediaQuery.textScaleFactor,
                              color: Colors.grey,
                            )
                        ),
                      ),
                    ),
                    if( leetcodeError )
                      Container(
                        padding: const EdgeInsets.only(top:4.0, left: 8.0),
                        width: mediaQuery.size.width * 0.92,
                        child: Text(
                          leetcodeErrorText,
                          style: TextStyle(
                              fontSize: 12 * mediaQuery.textScaleFactor,
                              color: Colors.red
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),

                    // codechef text field
                    SizedBox(
                      width: mediaQuery.size.width * 0.92,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            height: 30,
                            child: const Text(
                              "Codechef",
                              style: TextStyle(
                                color: Colors.black ,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              " *",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20 * mediaQuery.textScaleFactor
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: mediaQuery.size.width * 0.92,
                      height: mediaQuery.size.height * 0.065,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 10,
                              offset: const Offset(2, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: TextField(
                        onChanged: (value) {
                          if( codechefError ) {
                            setState(() {
                              codechefError = false;
                            });
                          }
                        },
                        controller: codechefController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: codechefError ? OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ) : OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(76, 215, 195, 1.0),
                                    width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            hintText: "Enter your CodeChef Link",
                            hintStyle: TextStyle(
                              fontSize: 14.0 * mediaQuery.textScaleFactor,
                              color: Colors.grey,
                            )
                        ),
                      ),
                    ),
                    if( codechefError )
                      Container(
                        padding: const EdgeInsets.only(top:4.0, left: 8.0),
                        width: mediaQuery.size.width * 0.92,
                        child: Text(
                          codechefErrorText,
                          style: TextStyle(
                              fontSize: 12 * mediaQuery.textScaleFactor,
                              color: Colors.red
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),

                    // sign up
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: const EdgeInsets.only(top:20.0),
                      child: SizedBox(
                        width: mediaQuery.size.width * 0.92,
                        height: mediaQuery.size.height * 0.065,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all( const Color.fromRGBO(233, 155, 154, 1) ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)
                                )
                            ),
                            elevation: MaterialStateProperty.all<double>(4.0),
                          ),
                          onPressed: () {
                            signUpUser( mediaQuery );
                          },
                          child: Text(
                            "Next",
                            style: TextStyle(
                                fontSize: 20.0 * mediaQuery.textScaleFactor,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                        ),
                      ),
                    ),

                    // terms and conditions
                    Container(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        width: mediaQuery.size.width * 0.8,
                        alignment: Alignment.bottomCenter,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "By Signing up, I hereby agree and accept the ",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const TextSpan(
                                  text: "Terms of Service",
                                  style: TextStyle(
                                    color: Color.fromRGBO(233, 145, 144, 1),
                                    fontWeight: FontWeight.w800,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2.0,
                                  ),
                                ),
                                TextSpan(
                                  text: " and ",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                    color: Color.fromRGBO(233, 145, 144, 1),
                                    fontWeight: FontWeight.w800,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2.0,
                                  ),
                                ),
                                TextSpan(
                                  text: " in use of the app.",
                                  style: TextStyle(
                                      color: Colors.grey.shade600
                                  ),
                                )
                              ]
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}

