import 'package:asha_project/widgets/pallete.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Moredetails extends StatefulWidget {
  final String pregUserId;

  const Moredetails({required this.pregUserId, Key? key}) : super(key: key);

  @override
  State<Moredetails> createState() => _MoredetailsState();
}

class _MoredetailsState extends State<Moredetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> trimester1Questions = [];
  List<String> trimester1Answers = [];
  List<String> trimester2Questions = [];
  List<String> trimester2Answers = [];
  List<String> trimester3Questions = [];
  List<String> trimester3Answers = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Retrieve existing fields from the collections
    fetchTrimesterFields();
  }

  void fetchTrimesterFields() async {
    final userId = widget.pregUserId;

    // Fetch fields from Trimester 1 collection
    final trimester1Ref = FirebaseFirestore.instance
        .collection('pregnantuser')
        .doc(userId)
        .collection('trimester one');
    final trimester1Snapshot = await trimester1Ref.get();
    trimester1Questions = [];
    trimester1Answers = [];
    for (final doc in trimester1Snapshot.docs) {
      final data = doc.data();
      final question = data.keys.first;
      final answer = data.values.first;
      trimester1Questions.add(question);
      trimester1Answers.add(answer);
    }

    // Fetch fields from Trimester 2 collection
    final trimester2Ref = FirebaseFirestore.instance
        .collection('pregnantuser')
        .doc(userId)
        .collection('trimester two');
    final trimester2Snapshot = await trimester2Ref.get();
    trimester2Questions = [];
    trimester2Answers = [];
    for (final doc in trimester2Snapshot.docs) {
      final data = doc.data();
      final question = data.keys.first;
      final answer = data.values.first;
      trimester2Questions.add(question);
      trimester2Answers.add(answer);
    }

    // Fetch fields from Trimester 3 collection
    final trimester3Ref = FirebaseFirestore.instance
        .collection('pregnantuser')
        .doc(userId)
        .collection('trimester three');
    final trimester3Snapshot = await trimester3Ref.get();
    trimester3Questions = [];
    trimester3Answers = [];
    for (final doc in trimester3Snapshot.docs) {
      final data = doc.data();
      final question = data.keys.first;
      final answer = data.values.first;
      trimester3Questions.add(question);
      trimester3Answers.add(answer);
    }

    setState(() {
      // Update the question and answer lists
    });
  }

  void _showAddQuestionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String question = '';
        String answer = '';

        return AlertDialog(
          title: Text('Add Question'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Question'),
                onChanged: (value) {
                  question = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Answer'),
                onChanged: (value) {
                  answer = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Save the question and answer to the respective collection
                final userId = widget.pregUserId;

                if (_tabController.index == 0) {
                  // Trimester 1
                  final collectionRef = FirebaseFirestore.instance
                      .collection('pregnantuser')
                      .doc(userId)
                      .collection('trimester one');
                  await collectionRef.doc(question).set({question: answer});
                } else if (_tabController.index == 1) {
                  // Trimester 2
                  final collectionRef = FirebaseFirestore.instance
                      .collection('pregnantuser')
                      .doc(userId)
                      .collection('trimester two');
                  await collectionRef.doc(question).set({question: answer});
                } else if (_tabController.index == 2) {
                  // Trimester 3
                  final collectionRef = FirebaseFirestore.instance
                      .collection('pregnantuser')
                      .doc(userId)
                      .collection('trimester three');
                  await collectionRef.doc(question).set({question: answer});
                }

                setState(() {
                  // Update the question and answer lists
                  if (_tabController.index == 0) {
                    trimester1Questions.add(question);
                    trimester1Answers.add(answer);
                  } else if (_tabController.index == 1) {
                    trimester2Questions.add(question);
                    trimester2Answers.add(answer);
                  } else if (_tabController.index == 2) {
                    trimester3Questions.add(question);
                    trimester3Answers.add(answer);
                  }
                });

                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
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
                    'Trimester 1',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Tab(
                  child: Text(
                    'Trimester 2',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Tab(
                  child: Text(
                    'Trimester 3',
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
                ListView.builder(
                  itemCount: trimester1Questions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(trimester1Questions[index]),
                        subtitle: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Pallete.MainColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(trimester1Answers[index]),
                        ));
                  },
                ),
                ListView.builder(
                  itemCount: trimester2Questions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(trimester2Questions[index]),
                        subtitle: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Pallete.MainColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(trimester2Answers[index]),
                        ));
                  },
                ),
                ListView.builder(
                  itemCount: trimester3Questions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(trimester3Questions[index]),
                        subtitle: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Pallete.MainColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(trimester3Answers[index]),
                        ));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.MainColor,
        onPressed: () {
          _showAddQuestionDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
