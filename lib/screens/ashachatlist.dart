import 'package:asha_project/screens/ashachat.dart';
import 'package:asha_project/widgets/pallete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatefulWidget {
  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  // Add this variable to store the current user instance ID
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.MainColor,
        title: Text('User List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('pregnantuser').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No users available.'));
          }

          final filteredDocs = snapshot.data!.docs
              .where((userDoc) =>
                  (userDoc.data() as Map<String, dynamic>?)
                          ?.containsKey('ashaWorkerId') ==
                      true &&
                  (userDoc.data() as Map<String, dynamic>?)?['ashaWorkerId'] ==
                      userId)
              .toList();

          if (filteredDocs.isEmpty) {
            return Center(child: Text('No users available.'));
          }

          return ListView.builder(
            itemCount: filteredDocs.length,
            itemBuilder: (context, index) {
              final userDoc = filteredDocs[index];
              final userId = userDoc.id;
              final basicDetailsCollection =
                  userDoc.reference.collection('basic details');

              return StreamBuilder<DocumentSnapshot>(
                stream: basicDetailsCollection.doc(userId).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      title: Text('Loading...'),
                    );
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return ListTile(
                      title: Text('User not found.'),
                    );
                  }

                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  final userName = userData['name'] as String? ?? '';

                  return ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(color: Colors.grey.withOpacity(0.5)),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Pallete.MainColor,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      // Handle user selection here
                      // You can navigate to chat screen or perform any desired action
                      // For example, you can navigate to a chat screen with the selected user
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreenasha(
                              userId: userId, userName: userName),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
