import 'package:asha_project/pregfunc/blogp.dart';
import 'package:asha_project/pregfunc/calendar.dart';
import 'package:asha_project/pregfunc/chat.dart';
import 'package:asha_project/screens/ashachatlist.dart';
import 'package:asha_project/screens/ashahome.dart';
import 'package:asha_project/screens/homepage.dart';
import 'package:asha_project/screens/profile.dart';
import 'package:asha_project/widgets/pallete.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarApp extends StatelessWidget {
  const BottomNavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarasha(),
    );
  }
}

class BottomNavigationBarasha extends StatefulWidget {
  const BottomNavigationBarasha({super.key});

  @override
  State<BottomNavigationBarasha> createState() =>
      _BottomNavigationBarashaState();
}

class _BottomNavigationBarashaState extends State<BottomNavigationBarasha> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    PregnantWomanListPage(),
    UserListPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 2,
        selectedItemColor: Pallete.MainColor,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          /* BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: 'Blog',
          ), */
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
