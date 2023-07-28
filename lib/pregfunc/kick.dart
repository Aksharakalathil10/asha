import 'package:asha_project/widgets/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KickCounterPage extends StatefulWidget {
  @override
  _KickCounterPageState createState() => _KickCounterPageState();
}

class _KickCounterPageState extends State<KickCounterPage> {
  int kickCount = 0;
  Stopwatch stopwatch = Stopwatch();
  List<KickRecord> kickRecords = [];

  void startTimer() {
    setState(() {
      kickCount = 0;
      stopwatch.reset();
      stopwatch.start();
    });
  }

  void stopTimer() {
    setState(() {
      stopwatch.stop();
      kickRecords.add(
        KickRecord(
          duration: stopwatch.elapsed,
          count: kickCount,
        ),
      );
    });
  }

  void recordKick() {
    setState(() {
      kickCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Pallete.MainColor),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.MainColor,
        title: Text('Kick Counter'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.pink[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tap the icon to start counting kicks',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                if (stopwatch.isRunning) {
                  recordKick();
                } else {
                  startTimer();
                }
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.child_care,
                  size: 100,
                  color: Pallete.MainColor,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              kickCount > 0 ? 'Kicks: $kickCount' : '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              stopwatch.isRunning
                  ? 'Duration: ${stopwatch.elapsed.inMinutes} min ${stopwatch.elapsed.inSeconds.remainder(60)} sec'
                  : '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            if (stopwatch.isRunning)
              ElevatedButton(
                onPressed: stopTimer,
                child: Text('Complete'),
              ),
            SizedBox(height: 20),
            ...kickRecords.map((record) => Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Duration: ${record.duration.inMinutes} min ${record.duration.inSeconds.remainder(60)} sec',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Kicks: ${record.count}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class KickRecord {
  final Duration duration;
  final int count;

  KickRecord({required this.duration, required this.count});
}
