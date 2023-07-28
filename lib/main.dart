import 'dart:developer';
import 'package:asha_project/screens/navbar.dart';
import 'package:asha_project/screens/navbarasha.dart';
import 'package:asha_project/screens/pregdeails.dart';

import 'package:asha_project/ui/login_pagepreg.dart';
import 'package:asha_project/ui/signuppreg.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:asha_project/widgets/pallete.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  //FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //for fetching a user
  /* DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection("pregnant woman")
      .doc("xrYKuImXQrpOPmtnzI88")
      .get();
  log(snapshot.data().toString()); */

  // to add details
  /* Map<String, dynamic> newUserData = {
    "name": "adithiya suresh",
    "email": "adithiyasuresh@gmail.com"
  }; */

  // for adding new user
  /* await _firestore
      .collection("pregnant woman")
      .doc("your-id-here")
      .set(newUserData); */

  // for updating any user details
  /* await _firestore
      .collection("pregnant woman")
      .doc("your-id-here")
      .update({"email": "adithiya2024@gmail.com"}); */

  // to delete user
  //await _firestore.collection("pregnant woman").doc("your-id-here").delete();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        home: (FirebaseAuth.instance.currentUser != null)
        
            ? StepperDemo()
            : LoginPreg());
  }
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          /*  appBar: AppBar(
              //  title: Text('Flutter Tabs Demo'),
              /*  bottom: TabBar(
              tabs: [
                   Tab(icon: Icon(Icons.contacts), text: "Tab 1"),
                 Tab(icon: Icon(Icons.camera_alt), text: "Tab 2")
              ],
            ), */
              ), */
          body: TabBarView(
            children: [
              LoginPreg(),
              SignPreg(),
            ],
          ),
        ),
      ),
    );
  }
}
