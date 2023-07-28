import 'package:asha_project/ui/login_pagepreg.dart';
import 'package:asha_project/widgets/pallete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ashadetail extends StatefulWidget {
  const ashadetail({super.key});

  @override
  State<ashadetail> createState() => _ashadetailState();
}

class _ashadetailState extends State<ashadetail> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();
  TextEditingController _aadharNumberController = TextEditingController();

  bool _isSaved = false;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _postalCodeController.dispose();
    _aadharNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchProfileDetails();
  }

  Future<void> fetchProfileDetails() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('basic details')
        .doc(userId)
        .get();
    if (snapshot.exists) {
      setState(() {
        _nameController.text = snapshot.get('Name');
        _addressController.text = snapshot.get('Address');
        _postalCodeController.text = snapshot.get('Postal Code');
        _aadharNumberController.text = snapshot.get('Aadhar Number');
        _isSaved = true;
      });
    }
  }

  Future<void> saveProfileDetails() async {
    // Retrieve the profile information
    String name = _nameController.text;
    String address = _addressController.text;
    String postalCode = _postalCodeController.text;
    String aadharNumber = _aadharNumberController.text;

    // Get the current user ID
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Create a collection called 'basic details' and add the user's input as the field and value
    await FirebaseFirestore.instance
        .collection('ashauser')
        .doc(userId)
        .collection('basic details')
        .doc(userId)
        .set({
      'Name': name,
      'Address': address,
      'Postal Code': postalCode,
      'Aadhar Number': aadharNumber,
    });

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => const LoginPreg()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Pallete.MainColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Address',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                hintText: 'Enter your address',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Postal Code',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _postalCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter your postal code',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Aadhar Number',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _aadharNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter your Aadhar number',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            SizedBox(height: 24),
            if (!_isSaved)
              Center(
                child: ElevatedButton(
                  onPressed: saveProfileDetails,
                  child: Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Pallete.MainColor,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
