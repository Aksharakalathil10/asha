import 'package:asha_project/screens/detail.dart';
import 'package:asha_project/ui/login_pagepreg.dart';
import 'package:asha_project/widgets/pallete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class PregnantWoman {
  final String name;
  final String trimester;
  final String userId;

  PregnantWoman(
      {required this.name, required this.trimester, required this.userId});
}

class PregnantWomanListPage extends StatefulWidget {
  @override
  _PregnantWomanListPageState createState() => _PregnantWomanListPageState();
}

class _PregnantWomanListPageState extends State<PregnantWomanListPage> {
  late List<PregnantWoman> pregnantWomen = [];
  late List<PregnantWoman> filteredWomen = [];
  final TextEditingController _searchController = TextEditingController();
  String filterTrimester = '';

  @override
  void initState() {
    super.initState();
    fetchPregnantWomen();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: ((context) => LoginPreg())));
  }

  void fetchPregnantWomen() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('pregnantuser').get();
    List<PregnantWoman> womenList = [];
    for (var doc in snapshot.docs) {
      String userId = doc.id;
      DocumentSnapshot basicDetailsSnapshot = await FirebaseFirestore.instance
          .collection('pregnantuser')
          .doc(userId)
          .collection('basic details')
          .doc(userId)
          .get();
      String name = basicDetailsSnapshot.get('name');
      String trimester = basicDetailsSnapshot.get('trimester');
      PregnantWoman woman =
          PregnantWoman(name: name, trimester: trimester, userId: userId);
      womenList.add(woman);
    }
    setState(() {
      pregnantWomen = womenList;
      filteredWomen = womenList;
    });
  }

  void filterPregnantWomen(String searchTerm, String trimester) {
    List<PregnantWoman> filteredList = pregnantWomen.where((woman) {
      bool nameMatches = woman.name.toLowerCase().contains(searchTerm);
      bool trimesterMatches = trimester.isEmpty || woman.trimester == trimester;
      return nameMatches && trimesterMatches;
    }).toList();
    setState(() {
      filteredWomen = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pregnant Women"),
        backgroundColor: Pallete.MainColor,
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'filter',
                child: Text('Filter'),
              ),
              PopupMenuItem<String>(
                value: 'clear',
                child: Text('Clear Filters'),
              ),
            ],
            onSelected: (value) {
              if (value == 'filter') {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Select Trimester',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    filterTrimester = '1';
                                    filterPregnantWomen(
                                      _searchController.text.toLowerCase(),
                                      filterTrimester,
                                    );
                                  });
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Pallete.MainColor,
                                ),
                                child: Text('1st Trimester'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    filterTrimester = '2';
                                    filterPregnantWomen(
                                      _searchController.text.toLowerCase(),
                                      filterTrimester,
                                    );
                                  });
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Pallete.MainColor,
                                ),
                                child: Text('2nd Trimester'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    filterTrimester = '3';
                                    filterPregnantWomen(
                                      _searchController.text.toLowerCase(),
                                      filterTrimester,
                                    );
                                  });
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Pallete.MainColor,
                                ),
                                child: Text('3rd Trimester'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (value == 'clear') {
                setState(() {
                  filterTrimester = '';
                  filterPregnantWomen(
                    _searchController.text.toLowerCase(),
                    filterTrimester,
                  );
                });
              }
            },
            child: Icon(Icons.filter_list),
          ),
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
                  filterPregnantWomen(
                    value.toLowerCase(),
                    filterTrimester,
                  );
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
                            DetailsPage(filteredWomen[index].userId),
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
                            Text(
                              "Trimester: ${filteredWomen[index].trimester}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
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
