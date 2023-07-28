import 'dart:developer';

import 'package:asha_project/screens/ashadetail.dart';
import 'package:asha_project/screens/pregdeails.dart';
import 'package:asha_project/ui/login_pagepreg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:asha_project/widgets/login_field.dart';
import 'package:asha_project/widgets/pallete.dart';

class SignPreg extends StatefulWidget {
  SignPreg({Key? key}) : super(key: key);

  @override
  State<SignPreg> createState() => _SignPregState();
}

class _SignPregState extends State<SignPreg> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String? selectedUserRole;
  String ashaCode = '123456789012'; // Example Asha code

  void createAccount() async {
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();
    String code = codeController.text.trim();

    if (email == "" || password == "" || selectedUserRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.grey,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 3),
        content: Text("Please fill in all the details"),
      ));
    } else {
      if (selectedUserRole == 'ashauser' && code != ashaCode) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.grey,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 3),
          content: Text("Invalid Asha code"),
        ));
        return;
      }

      try {
        // Create new account
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        if (userCredential.user != null) {
          String userId = userCredential.user!.uid;
          String collectionName =
              selectedUserRole == 'pregnantuser' ? 'pregnantuser' : 'ashauser';

          // Create a document in the respective collection with the user details
          await FirebaseFirestore.instance
              .collection(collectionName)
              .doc(userId)
              .set({
            'email': email,
            'password': password,
            'role': selectedUserRole,
          });
          if (selectedUserRole == 'pregnantuser') {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (ctx) {
              return StepperDemo();
            }));
          } else {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (ctx) {
              return ashadetail();
            }));
          }
        }
      } on FirebaseAuthException catch (ex) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.grey,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 1),
          content: Text(ex.code.toString()),
        ));
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
              padding: EdgeInsets.all(60),
              child: Column(
                children: [
                  const Text(
                    'Welcome.',
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
                    controller: emailcontroller,
                    decoration: const InputDecoration(
                      hintText: "email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: passwordcontroller,
                    decoration: const InputDecoration(
                      hintText: "password",
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 10)),
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
                  const SizedBox(height: 15),
                  if (selectedUserRole == 'ashauser')
                    TextField(
                      controller: codeController,
                      decoration: const InputDecoration(
                        hintText: "12-digit Asha code",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      createAccount();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(395, 55),
                      backgroundColor: Pallete.MainColor,
                      shadowColor: Pallete.MainColor,
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Image.asset(
                      "C:/Users/DELL/OneDrive/Documents/asha_project/assets/pregnant-woman-4385448-3649296.png")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
