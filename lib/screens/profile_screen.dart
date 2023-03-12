import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_search_app/screens/sign_in_screen.dart';
import 'package:job_search_app/utils/hive_services.dart';

import '../widgets/custom_dialog.dart';

class ProfilePage extends StatefulWidget {
  final Map<dynamic, dynamic> userDetails;

  const ProfilePage({Key? key, required this.userDetails}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  HiveServices hiveServices = HiveServices();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),

              // Profile page
              Container(
                margin: const EdgeInsets.all( 12.0, ),
                height: mediaQuery.size.height * 0.4,
                width: mediaQuery.size.width * 0.93,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular( 25.0,),
                  color: const Color(0xFF111315),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Profile photo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric( horizontal: 12.0, ),
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              )
                          ),
                        ),

                        ClipRRect(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0, ),
                            width: mediaQuery.size.width * 0.25,
                            height: mediaQuery.size.width * 0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0,),
                              color: Colors.grey,
                            ),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.symmetric( horizontal: 12.0, ),
                          child: IconButton(
                              onPressed: () {
                                // deleting the box logged_user and redirecting to sign_in_screen
                                hiveServices.deleteBox("logged_user");

                                // Redirecting user to SignInScreen
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => SignInScreen(),
                                    )
                                );
                              },
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.white,
                              )
                          ),
                        ),
                      ],
                    ),

                    // Name
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0, ),
                      child: Text(
                        widget.userDetails['name'],
                        style: const TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Post
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0, ),
                      child: Text(
                        widget.userDetails['email'],
                        style: const TextStyle(
                          color: Color(0xff747577),
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0, ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric( horizontal: 2.0, ),
                            child: const Icon(
                              Icons.location_on_outlined,
                              color: Color(0xff747577),
                              size: 18,
                            ),
                          ),
                          Text(
                            "${widget.userDetails['city']} ${widget.userDetails['state']}, ${widget.userDetails['country']}",
                            style: const TextStyle(
                              color: Color(0xff747577),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric( horizontal: 16.0, vertical: 8.0, ),
                child: const Text(
                  "experience",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric( horizontal: 8.0, ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric( horizontal: 8.0, ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.black
                          ),
                        ),
                        width: mediaQuery.size.width * 0.7,
                        height: mediaQuery.size.width * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only( left: 12.0, top: 16.0, bottom: 6.0, ),
                              child: const Text(
                                "UC Barkleys",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.symmetric( horizontal: 12.0, vertical: 4.0, ),
                              child: const Text(
                                "Software Developer 2",
                                style: TextStyle(
                                ),
                              ),
                            ),

                            // start date and end date
                            Container(
                              margin: const EdgeInsets.symmetric( horizontal: 12.0, vertical: 4.0, ),
                              child: const Text(
                                "01-03-2023 - 01-03-2023",
                                style: TextStyle(
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // add Experience
                      GestureDetector(
                        onTap: () {
                          // showing a popup to add new experience
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: CustomDialog(
                                  userDetails: widget.userDetails,
                                ),
                              )
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.black
                            ),
                          ),
                          width: mediaQuery.size.width * 0.4,
                          height: mediaQuery.size.width * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric( vertical: 4.0, ),
                                child: const Icon(
                                  Icons.add,
                                  size: 28,
                                ),
                              ),
                              const Text("Add Experience")
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// "user_id": 3,
// "name": "Pranav Kale",
// "email": "pranavkale021998@gmail.com",
// "password": "pranav123",
// "phone": "7756956788",
// "city": "Pune",
// "state": "Maharashtra",
// "country": "India",
// "profile_pic": "null",
// "banner_pic": "null",
// "github": "pranav-kale-01",
// "leetcode": "pranavkale013",
// "codechef": "pranavkale013",
// "created_at": "2023-03-12T00:06:23.789480+05:30"