import 'package:asha_project/pregfunc/detailshow.dart';
import 'package:asha_project/pregfunc/emergency.dart';
import 'package:asha_project/pregfunc/kick.dart';
import 'package:asha_project/pregfunc/notifi.dart';
import 'package:asha_project/pregfunc/weight.dart';
import 'package:asha_project/ui/login_pagepreg.dart';
import 'package:asha_project/widgets/pallete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';
  void initState() {
    super.initState();
    fetchUserName();
  }

  void fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('pregnantuser')
          .doc(userId)
          .collection('basic details')
          .doc(userId)
          .get();
      setState(() {
        userName = snapshot.get('name');
      });
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: ((context) => LoginPreg())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.MainColor,
        title: Text('Hi, $userName'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon tap
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return NotificationScreen();
              }));
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app_outlined),
            onPressed: () {
              logout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[200],
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  children: [
                    Image.asset(
                        'C:/Users/DELL/OneDrive/Documents/asha_project/assets/pregnant-woman-4385448-3649296.png'),
                    SizedBox(height: 16),
                    Text(
                      "Let's Prepare Your Pregnancy",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                IconCard(
                  icon: Icons.bedroom_baby,
                  text: 'Kick\nCounter',
                  routeName: KickCounterPage(),
                ),
                IconCard(
                  icon: Icons.pregnant_woman,
                  text: 'Your\nDetails',
                  routeName: PregnantWomanDetailsPage(),
                ),
              ]),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                IconCard(
                  icon: Icons.local_hospital,
                  text: 'Emergency\nContacts',
                  routeName: EmergencyContactsScreen(),
                ),
                IconCard(
                  icon: Icons.monitor_weight,
                  text: 'weight\ncalculator',
                  routeName: AddWeightPage(),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class IconCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget routeName;

  IconCard({
    required this.icon,
    required this.text,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return routeName;
        }));
      },
      child: Container(
        width: 170,
        height: 170,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 70,
              color: Pallete.MainColor,
            ),
            SizedBox(height: 16),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
