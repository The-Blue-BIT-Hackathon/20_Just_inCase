import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:job_search_app/screens/sign_in_screen.dart';
import 'package:job_search_app/utils/hive_services.dart';
import 'package:job_search_app/widgets/add_education_dialog.dart';
import 'package:job_search_app/widgets/experience_tile.dart';
import 'package:http/http.dart' as http;

import '../widgets/custom_dialog.dart';

class ProfilePage extends StatefulWidget {
  final Map<dynamic, dynamic> userDetails;

  const ProfilePage({Key? key, required this.userDetails}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  HiveServices hiveServices = HiveServices();
  List<dynamic> experiences = [];
  List<dynamic> educations = [];

  @override
  void initState( ) {
    super.initState();

    getExperiences();
  }

  Future<void> getExperiences() async {
    // getting the list of experiences
    String url = "http://jobseekerapi.onrender.com/api/getexperiencesofuser/${widget.userDetails['user_id']}";

    http.Response response = await http.get(
      Uri.parse( url ),
    );

    debugPrint("Status Code - ${response.statusCode}");
    if( response.statusCode == 200 ) {
      experiences = jsonDecode(response.body);
      debugPrint( experiences.toString() );

      setState(() {
        debugPrint("RESPONSE BODY - ${response.body}");
      });
    }
    else {
      debugPrint("Unable to load response");
      debugPrint("status Code - ${response.statusCode}");
    }
  }

  Future<void> getEducation() async {

  }

  Future<void> addExperience( Map<String, dynamic> data ) async {
    // sending request to add experience
    String url = "https://jobseekerapi.onrender.com/api/createexperience";

    http.Response response = await http.post(
      Uri.parse( url ),
      body: jsonEncode(data),
    );

    if( response.statusCode == 200 || response.statusCode == 415 ) {
      // add experience to list of experiences
      setState(() {
        experiences.add( data );
      });
    }
    else {
      debugPrint("Unable to load response");
      debugPrint("Status code - ${response.statusCode}");
    }
  }

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

              const SizedBox(
                height: 10,
              ),

              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric( horizontal: 16.0, vertical: 12.0, ),
                child: const Text(
                  "Experience",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric( horizontal: 8.0, ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...experiences.map((e) => ExperienceTile(
                        title: e['company'],
                        position: e['position'],
                        startDate: e['start_date'],
                        endDate: e['end_date'],
                        currentlyWorking: e['isWorking'].toString().toLowerCase() == "true",
                      )),

                      // add Experience
                      GestureDetector(
                        onTap: () {
                          // showing a popup to add new experience
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: AddEducationDialog(
                                  onClick: addExperience,
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
              ),

              const SizedBox(
                height: 20,
              ),

              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric( horizontal: 16.0, vertical: 12.0, ),
                child: const Text(
                  "Education",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric( horizontal: 8.0, ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...educations.map((e) => ExperienceTile(
                        title: e['company'],
                        position: e['position'],
                        startDate: e['start_date'],
                        endDate: e['end_date'],
                        currentlyWorking: e['isWorking'].toString().toLowerCase() == "true",
                      )),

                      // add Experience
                      GestureDetector(
                        onTap: () {
                          // showing a popup to add new experience
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: CustomDialog(
                                  onClick: addExperience,
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
                              const Text("Add Education")
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