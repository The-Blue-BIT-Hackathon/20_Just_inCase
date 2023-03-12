import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_search_app/screens/feed_screen.dart';
import 'package:job_search_app/screens/main_page.dart';
import 'package:job_search_app/screens/prep_screen.dart';
import 'package:job_search_app/screens/profile_screen.dart';

import 'package:job_search_app/utils/hive_services.dart';

class HomeScreen extends StatefulWidget {
  final UserCredential user;
  final Map<dynamic, dynamic> userDetails;

  const HomeScreen({Key? key, required this.user, required this.userDetails}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HiveServices hiveServices = HiveServices();

  int _selectedIndex = 0;
  List<Widget> screens = [
    const FeedPage(),
    const MainPage(),
    const PrepScreeen(),
    // const FeedPage()
  ];

  late Widget currentScreen;

  @override
  void initState( ) {
    super.initState();

    // setting the default current screen as home screen
    currentScreen = screens[0];
  }

  void _onItemTapped(int index) {
    // setting the current screen at screen at current index
    currentScreen = screens[index];

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 4.0,
            ),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    // Navigating to the profile screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          userDetails: widget.userDetails,
                        ),
                      )
                    );
                  });
                },
                icon: const Icon(
                    Icons.person,
                    color: Colors.black,
                ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Preparations',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   label: 'Profile',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: Container(
        alignment: Alignment.center,
        child: currentScreen
      ),
    );
  }
}

