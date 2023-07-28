import 'package:asha_project/widgets/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? currentUserId;
  String? chatRoomId;

  @override
  void initState() {
    super.initState();
    getCurrentUserId();
    getChatRoomId();
  }

  Future<void> getCurrentUserId() async {
    final User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      currentUserId = user?.uid;
    });
  }

  Future<void> getChatRoomId() async {
    final QuerySnapshot snapshot = await _firestore
        .collection('chatRooms')
        .where('pregnantUserId', isEqualTo: currentUserId)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final chatRoom = snapshot.docs[0];
      setState(() {
        chatRoomId = chatRoom.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserId == null || chatRoomId == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.MainColor,
        title: Text('Chat Section'),
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
                    // Determine the alignment of the message based on the sender
                    final messageAlignment = senderId == currentUserId
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start;

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Column(
                        crossAxisAlignment: messageAlignment,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: senderId == currentUserId
                                  ? Pallete.MainColor.withOpacity(0.3)
                                  : Colors.grey.withOpacity(0.3),
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
                      _sendMessage(chatRoomId!, currentUserId!, message);
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

  Future<void> _sendMessage(
      String chatRoomId, String senderId, String message) async {
    final chatRoomRef = _firestore.collection('chatRooms').doc(chatRoomId);

    await chatRoomRef.collection('messages').add({
      'senderId': senderId,
      'message': message,
      'timestamp': Timestamp.now(),
    });
  }
}
