import 'package:asha_project/widgets/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreenasha extends StatefulWidget {
  final String userId;
  final String userName;

  const ChatScreenasha({required this.userId, required this.userName});

  @override
  _ChatScreenashaState createState() => _ChatScreenashaState();
}

class _ChatScreenashaState extends State<ChatScreenasha> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String currentUserId;
  String? chatRoomId;

  @override
  void initState() {
    super.initState();
    getCurrentUserId();
    chatRoomId = widget.userId;
  }

  Future<void> getCurrentUserId() async {
    final User? user = _auth.currentUser;
    setState(() {
      currentUserId = user?.uid ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserId == null || chatRoomId == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.MainColor,
        title: Text("chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chatRooms')
                  .doc(chatRoomId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No messages yet.'));
                }

                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final messageData = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    final String senderId =
                        messageData['senderId'] as String? ?? '';
                    final String message =
                        messageData['message'] as String? ?? '';
                    final messageAlignment = senderId == currentUserId
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start;

                    final messageColor = senderId == currentUserId
                        ? Colors.grey.withOpacity(0.3)
                        : Pallete.MainColor.withOpacity(0.3);

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Column(
                        crossAxisAlignment: messageAlignment,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: messageColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(message),
                          ),
                          SizedBox(height: 5),
                          if (index == snapshot.data!.docs.length - 1)
                            Text(
                              'Sent at ${messageData['timestamp']}',
                              style: TextStyle(fontSize: 10),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final String message = _messageController.text.trim();
                    if (message.isNotEmpty) {
                      _sendMessage(widget.userId, message);
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage(String receiverId, String message) async {
    final chatRoomRef = _firestore.collection('chatRooms').doc(chatRoomId);

    await chatRoomRef.collection('messages').add({
      'senderId': currentUserId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': Timestamp.now(),
    });
  }
}
