import 'package:asha_project/jhpn/ashaprofile.dart';
import 'package:asha_project/screens/detail.dart';
import 'package:asha_project/screens/profile.dart';
import 'package:asha_project/ui/login_pagepreg.dart';
import 'package:asha_project/widgets/pallete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class PregnantWoman {
  final String name;
  final String userId;

  PregnantWoman({
    required this.name,
    required this.userId,
  });
}

class ashaListPage extends StatefulWidget {
  @override
  _ashaListPageState createState() => _ashaListPageState();
}

class _ashaListPageState extends State<ashaListPage> {
  late List<PregnantWoman> pregnantWomen = [];
  late List<PregnantWoman> filteredWomen = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPregnantWomen();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: ((context) => LoginPreg())),
    );
  }

  void fetchPregnantWomen() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('ashauser').get();
    List<PregnantWoman> womenList = [];
    for (var doc in snapshot.docs) {
      String userId = doc.id;
      DocumentSnapshot basicDetailsSnapshot = await FirebaseFirestore.instance
          .collection('ashauser')
          .doc(userId)
          .collection('basic details')
          .doc(userId)
          .get();
      String name = basicDetailsSnapshot.get('Name');

      PregnantWoman woman = PregnantWoman(name: name, userId: userId);
      womenList.add(woman);
    }
    setState(() {
      pregnantWomen = womenList;
      filteredWomen = womenList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asha workers"),
        backgroundColor: Pallete.MainColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app_outlined),
            onPressed: () {
              logout();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  filteredWomen = pregnantWomen.where((woman) {
                    return woman.name
                        .toLowerCase()
                        .contains(value.toLowerCase());
                  }).toList();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredWomen.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ashaprofile(filteredWomen[index].userId)
                          // DetailsPage(filteredWomen[index].userId),
                          ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 246, 246, 246),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Pallete.MainColor,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              filteredWomen[index].name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BlankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blank Page"),
        backgroundColor: Pallete.MainColor,
      ),
    );
  }
}
