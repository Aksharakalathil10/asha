// details page of pregnantwoman in the asha worker home page
import 'dart:developer';

import 'package:asha_project/screens/adddetails.dart';
import 'package:asha_project/widgets/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsPage extends StatefulWidget {
  final String _userId;
  DetailsPage(this._userId) {
    // Constructor logic here
  }
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _dueDateController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _coronavaccineController = TextEditingController();

  TextEditingController _ttvaccineController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    fetchUserData(widget._userId);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _dueDateController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _coronavaccineController.dispose();
    _ttvaccineController.dispose();
    super.dispose();
  }

  Future<void> createTrimesterCollections(String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('pregnantuser')
          .doc(userId)
          .collection('trimester one');

      await FirebaseFirestore.instance
          .collection('pregnantuser')
          .doc(userId)
          .collection('trimester two');

      await FirebaseFirestore.instance
          .collection('pregnantuser')
          .doc(userId)
          .collection('trimester three');

      print('Trimester collections created successfully!');
    } catch (e) {
      print('Error creating trimester collections: $e');
      // Handle error here
    }
  }

  Future<void> fetchUserData(String _userId) async {
    try {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('pregnantuser')
          .doc(_userId)
          .collection('basic details')
          .doc(_userId)
          .get();
      DocumentSnapshot document1 = await FirebaseFirestore.instance
          .collection('pregnantuser')
          .doc(_userId)
          .collection('health details')
          .doc(_userId)
          .get();
      DocumentSnapshot document2 = await FirebaseFirestore.instance
          .collection('pregnantuser')
          .doc(_userId)
          .collection('vaccination')
          .doc(_userId)
          .get();

      if (document.exists || document1.exists || document2.exists) {
        Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
        Map<String, dynamic> userData1 =
            document1.data() as Map<String, dynamic>;
        Map<String, dynamic> userData2 =
            document2.data() as Map<String, dynamic>;

        _nameController.text = userData['name'] ?? '';
        _ageController.text = userData['age'] ?? '';
        _addressController.text = userData['address'] ?? '';
        _dueDateController.text = userData['dueDate'] ?? '';
        _weightController.text = userData1['weight'] ?? '';
        _heightController.text = userData1['height'] ?? '';
        _ttvaccineController.text = userData2['coronaVaccine'] ?? '';

        _coronavaccineController.text = userData2['ttVaccine'] ?? '';

        setState(() {});
      } else {
        log("not there");
      }
    } catch (e) {
      // Handle errors here
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.MainColor,
        title: Text(
          'Pregnant Woman Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Pallete.MainColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Pallete.MainColor,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _nameController.text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Pallete.MainColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Pallete.MainColor,
                borderRadius: BorderRadius.circular(30),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  child: Text(
                    'Personal',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Tab(
                  child: Text(
                    'Health',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Tab(
                  child: Text(
                    'Vaccination',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildEditableField(
                          'Name',
                          _nameController,
                        ),
                        _buildEditableField(
                          'Age',
                          _ageController,
                        ),
                        _buildEditableField(
                          'Address',
                          _addressController,
                        ),
                        _buildEditableField(
                          'Due Date',
                          _dueDateController,
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildEditableField(
                          'Weight',
                          _weightController,
                        ),
                        _buildEditableField(
                          'Height',
                          _heightController,
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildEditableField(
                          'Covid Dose',
                          _coronavaccineController,
                        ),
                        _buildEditableField(
                          'tt Vaccine (Yes/No)',
                          _ttvaccineController,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createTrimesterCollections(widget._userId);
          // Perform action on floating button press
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Moredetails(
                  pregUserId: widget._userId,
                ),
              ));
        },
        backgroundColor: Pallete.MainColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
