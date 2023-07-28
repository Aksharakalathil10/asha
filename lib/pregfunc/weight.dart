import 'package:asha_project/widgets/pallete.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddWeightPage extends StatefulWidget {
  const AddWeightPage({Key? key}) : super(key: key);

  @override
  _AddWeightPageState createState() => _AddWeightPageState();
}

class _AddWeightPageState extends State<AddWeightPage> {
  final weightController = TextEditingController();
  DateTime? selectedDate;
  List<Map<String, dynamic>> weightHistory = [];

  void _submitWeight() {
    if (selectedDate != null && weightController.text.isNotEmpty) {
      setState(() {
        weightHistory.add({
          'date': selectedDate,
          'weight': double.parse(weightController.text),
        });
      });
      weightController.clear();
      selectedDate = null;
    }
  }

  Widget _buildWeightHistoryTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Weight')),
      ],
      rows: weightHistory.map((weightEntry) {
        final date = DateFormat.yMd().format(weightEntry['date'] as DateTime);
        final weight = weightEntry['weight'].toString();
        return DataRow(
          cells: [
            DataCell(Text(date)),
            DataCell(Text(weight)),
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.MainColor,
        title: const Text('Add Weight'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Current Weight',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 60,
            ),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Weight (in kg)',
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: const ColorScheme.light().copyWith(
                          primary: Pallete.MainColor,
                          onPrimary: Colors.white,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            primary: Pallete.MainColor,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              child: Text(
                selectedDate != null
                    ? 'Selected Date: ${DateFormat.yMd().format(selectedDate!)}'
                    : 'Select Date',
              ),
            ),
            const SizedBox(height: 56),
            ElevatedButton(
              onPressed:
                  (selectedDate != null && weightController.text.isNotEmpty)
                      ? _submitWeight
                      : null,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 62),
            const Text(
              'Weight History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: _buildWeightHistoryTable(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
