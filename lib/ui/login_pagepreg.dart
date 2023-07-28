import 'dart:developer';


import 'package:asha_project/screens/navbar.dart';
import 'package:asha_project/screens/navbarasha.dart';
import 'package:asha_project/ui/adminnav.dart';
import 'package:asha_project/ui/signuppreg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:asha_project/widgets/pallete.dart';

class ashaDetails {
  final String email;
  final String password;
  final String role;

  ashaDetails({
    required this.email,
    required this.password,
    required this.role,
  });
}

class UserDetails {
  final String email;
  final String password;
  final String role;

  UserDetails({
    required this.email,
    required this.password,
    required this.role,
  });
}

class LoginPreg extends StatefulWidget {
  const LoginPreg({Key? key}) : super(key: key);

  @override
  State<LoginPreg> createState() => _LoginPregState();
}

class _LoginPregState extends State<LoginPreg> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // String? selectedUserRole = 'Pregnant User';
  String? selectedUserRole;
  UserDetails? currentUser;

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == '' || password == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.grey,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 1),
          content: Text('Please fill in the details'),
        ),
      );
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          String userId = userCredential.user!.uid;
          String collectionName =
              selectedUserRole == 'pregnantuser' ? 'pregnantuser' : 'ashauser';

          // Fetch user data from the respective collection
          DocumentSnapshot<Map<String, dynamic>> userDataSnapshot =
              await FirebaseFirestore.instance
                  .collection(collectionName)
                  .doc(userId)
                  .get();

          if (userDataSnapshot.exists) {
            // Create a UserDetails object with the fetched data
            UserDetails user = UserDetails(
              email: userDataSnapshot['email'],
              password: userDataSnapshot['password'],
              role: selectedUserRole!,
            );

            setState(() {
              currentUser = user; // Update the currentUser variable
            });

            // Navigate to a screen to display the current user details
            //Navigator.of(context).pushReplacement(
            // MaterialPageRoute(builder: (ctx) {
            // return UserDetailsScreen(currentUser: currentUser!);
            //}),
            // );
          }
          Navigator.popUntil(context, (route) => route.isFirst);
          if (selectedUserRole == 'ashauser') {
            // Redirect to Asha Worker home page
            // Replace the below line with the appropriate Asha Worker home page
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) {
                return BottomNavigationBarApp();
              }),
            );
          } else if (email == 'admin@jhpn.org' && password == 'admin123') {
            // Redirect to Admin (JHPN) home page
            // Replace the below line with the appropriate Admin home page
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) {
                return BottomNavigationBarjhpn();
              }),
            );
          } else {
            // Redirect to Pregnant user home page
            // Replace the below line with the appropriate Pregnant user home page
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) {
                return const BottomNavigationBarExample();
              }),
            );
          }
        }
      } on FirebaseAuthException catch (ex) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.grey,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 1),
            content: Text(ex.code.toString()),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(60),
              child: Column(
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      color: Pallete.MainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const SizedBox(height: 20),
                  const SizedBox(height: 15),
                  const SizedBox(height: 15),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: selectedUserRole,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      hintText: 'Choose Role',
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        selectedUserRole = value;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: 'pregnantuser',
                        child: Text('Pregnant User'),
                      ),
                      DropdownMenuItem(
                        value: 'ashauser',
                        child: Text('Asha Worker'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(395, 55),
                      backgroundColor: Pallete.MainColor,
                      shadowColor: Pallete.MainColor,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'New user? Swipe left to register ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                          fontSize: 9,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return SignPreg();
                          }));
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Image.asset(
                    'C:/Users/DELL/OneDrive/Documents/asha_project/assets/pregnant-woman-4385448-3649296.png',
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
