import 'package:asha_project/widgets/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({Key? key}) : super(key: key);

  @override
  _EmergencyContactsScreenState createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  List<Map<String, String>> emergencyContacts = [];

  @override
  void initState() {
    super.initState();

    // Retrieve existing emergency contacts
    fetchEmergencyContacts();
  }

  void fetchEmergencyContacts() async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid; // Current user ID
// Add the logic to get the current user's ID

    final emergencyContactsRef = FirebaseFirestore.instance
        .collection('pregnantuser')
        .doc(userId)
        .collection('emergency contacts');

    final emergencyContactsSnapshot = await emergencyContactsRef.get();

    setState(() {
      emergencyContacts = emergencyContactsSnapshot.docs
          .map((doc) => {
                'name': doc['name'] as String,
                'number': doc['number'] as String,
              })
          .toList();
    });
  }

  void _callEmergencyContact(String number) async {
    final url = 'tel:$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle error when the phone call is not available
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to make a phone call.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _showAddContactDialog() {
    String name = '';
    String number = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {
                name = value;
              },
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              onChanged: (value) {
                number = value;
              },
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Number'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              final userId =
                  user?.uid; // Add the logic to get the current user's ID

              final emergencyContactsRef = FirebaseFirestore.instance
                  .collection('pregnantuser')
                  .doc(userId)
                  .collection('emergency contacts');

              await emergencyContactsRef.add({
                'name': name,
                'number': number,
              });

              setState(() {
                emergencyContacts.add({'name': name, 'number': number});
              });

              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.MainColor,
        title: const Text('Emergency Contacts'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: emergencyContacts.length,
        itemBuilder: (context, index) {
          final contact = emergencyContacts[index];
          return ListTile(
            title: Text(contact['name'] ?? ''),
            subtitle: Text(contact['number'] ?? ''),
            trailing: IconButton(
              icon: const Icon(Icons.call),
              onPressed: () {
                _callEmergencyContact(contact['number'] ?? '');
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddContactDialog();
        },
        child: const Icon(Icons.add),
        backgroundColor: Pallete.MainColor,
      ),
    );
  }
}
