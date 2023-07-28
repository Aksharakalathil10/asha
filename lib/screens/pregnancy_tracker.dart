import 'package:flutter/material.dart';

class PregnancyTrackerPage extends StatefulWidget {
  @override
  _PregnancyTrackerPageState createState() => _PregnancyTrackerPageState();
}

class _PregnancyTrackerPageState extends State<PregnancyTrackerPage> {
  int weeks = 0;
  int days = 0;

  void incrementWeeks() {
    setState(() {
      weeks++;
    });
  }

  void decrementWeeks() {
    if (weeks > 0) {
      setState(() {
        weeks--;
      });
    }
  }

  void incrementDays() {
    setState(() {
      if (days < 6) {
        days++;
      } else {
        days = 0;
        incrementWeeks();
      }
    });
  }

  void decrementDays() {
    setState(() {
      if (days > 0) {
        days--;
      } else if (weeks > 0) {
        days = 6;
        decrementWeeks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pregnancy Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Weeks',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$weeks',
              style: TextStyle(fontSize: 48),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: decrementWeeks,
                ),
                SizedBox(width: 16),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: incrementWeeks,
                ),
              ],
            ),
            SizedBox(height: 32),
            Text(
              'Days',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$days',
              style: TextStyle(fontSize: 48),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: decrementDays,
                ),
                SizedBox(width: 16),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: incrementDays,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
