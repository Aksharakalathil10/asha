import 'package:asha_project/ui/login_pagepreg.dart';
import 'package:asha_project/widgets/pallete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  DateTime? selectedDueDate;
  TextEditingController dueDateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController trimesterController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController coronaVaccineController = TextEditingController();
  TextEditingController ttVaccineController = TextEditingController();

  Future<void> selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Pallete.MainColor, // Set the primary color to pink
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                color: Pallete.MainColor, // Set the text color to pink
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDueDate) {
      setState(() {
        selectedDueDate = picked;
        dueDateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  FormField buildTextFormField({
    TextEditingController? controller,
    String? labelText,
    String? Function(String?)? validator,
    bool isNumeric = false,
  }) {
    return FormField (
      initialValue:
          controller?.text, // Set initial value to the controller's text
      builder: (FormFieldState state) {
        return TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            errorText:
                state.errorText, // Show error message from the FormField state
          ),
          onChanged: (value) {
            // Clear the previous error message when the user starts typing
            if (state.errorText != null) {
              state.didChange(null);
            }
          },
          validator: (value) {
            if (value?.isNotEmpty == true) {
              // Validate the input using the provided validator only when the field is not empty
              if (validator != null) {
                return validator(value);
              }
            }
            return null; // Return null to indicate valid input or empty field
          },
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        );
      },
    );
  }

  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.MainColor,
        automaticallyImplyLeading: false,
        title: Text('Register Your Account'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 25.0 ,horizontal: 25.0),
        child: Theme(
          data: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Pallete.MainColor,
                  background: Colors.grey,
                  secondary: Pallete.MainColor,
                ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Stepper(
                  type: stepperType,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  steps: <Step>[
                    Step(
                      title: const Text('Basic \nDetails'),
                      content: Column(
                        children: <Widget>[
                          buildTextFormField(
                            controller: nameController,
                            labelText: 'Name',
                            validator: (value) {
                              if (value?.isEmpty == true) {
                                return 'Please enter a valid name';
                              } else {
                                return null;
                              }
                            },
                          ),
                          buildTextFormField(
                            controller: ageController,
                            labelText: 'Age',
                            validator: (value) {
                              if (value?.isEmpty == true) {
                                return 'Please enter your age';
                              }
                              int? age = int.tryParse(value ?? '');
                              if (age == null || age <= 0 || age >= 150) {
                                return 'Please enter a valid age';
                              }
                              if (age < 18) {
                                return 'You are not eligible for pregnancy';
                              }
                              return null;
                            },
                            isNumeric: true,
                          ),
                          buildTextFormField(
                              controller: addressController,
                              labelText: 'Address'),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Postal code'),
                          ),
                          TextFormField(
                            controller: aadharController,
                            decoration: const InputDecoration(
                                labelText: 'Aadhar Number'),
                          ),
                          TextFormField(
                            controller: dueDateController,
                            readOnly: true,
                            onTap: () => selectDueDate(context),
                            decoration: InputDecoration(
                              labelText: 'Due Date',
                            ),
                          ),
                          TextFormField(
                            controller: trimesterController,
                            decoration:
                                const InputDecoration(labelText: 'Trimester'),
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'LMP Date'),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Abortion if any (Yes/No)'),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: Text('Health \nDetails'),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: weightController,
                            decoration: const InputDecoration(
                                labelText: 'weight in Kg'),
                          ),
                          TextFormField(
                            controller: heightController,
                            decoration: const InputDecoration(
                                labelText: 'Height in Kg'),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Urine test (Yes/No)'),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Blood sugar test (Yes/No)'),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText:
                                    'Contact with any covid +ve patients in last 14 days (Yes/No)'),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Any On going disease'),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: const Text('Vaccination'),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: coronaVaccineController,
                            decoration: const InputDecoration(
                                labelText: 'Corona vaccine (Yes/No)'),
                          ),
                          TextFormField(
                            controller: ttVaccineController,
                            decoration: const InputDecoration(
                                labelText: 'TT Vaccine (Yes/No)'),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'TT Vaccine Date'),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Function to assign an Asha worker to the current pregnant woman
  void assignAshaWorkerToCurrentPregnantWoman(
      String currentPregnantWomanId) async {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user!.uid;
    // Fetch the Asha workers
    QuerySnapshot ashaWorkersSnapshot =
        await FirebaseFirestore.instance.collection('ashauser').get();

    // Create a list to store Asha worker IDs
    List<String> ashaWorkerIds = ashaWorkersSnapshot.docs
        .map((doc) => doc.id) // Assuming Asha worker ID is the document ID
        .toList();

    // Randomly select an Asha worker from the list
    String assignedAshaWorkerId =
        ashaWorkerIds[Random().nextInt(ashaWorkerIds.length)];

    // Update the assigned Asha worker ID for the current pregnant woman
    FirebaseFirestore.instance
        .collection('pregnantuser')
        .doc(currentPregnantWomanId)
        .update({'ashaWorkerId': assignedAshaWorkerId});

    createChatRoom(userId, assignedAshaWorkerId);
  }

  Future<void> createChatRoom(
      String pregnantUserId, String ashaWorkerId) async {
    CollectionReference chatRoomRef =
        FirebaseFirestore.instance.collection('chatRooms');

    await chatRoomRef.doc(pregnantUserId).set({
      'pregnantUserId': pregnantUserId,
      'ashaWorkerId': ashaWorkerId,
    });
  }

  void saveForm() async {
    // Access the current user ID from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user!.uid;

    // Create a reference to the "pregnant user" collection for the current user
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('pregnantuser');

    // Create a document for basic details
    await userCollection
        .doc(userId)
        .collection('basic details')
        .doc(userId)
        .set({
      'name': nameController.text,
      'age': ageController.text,
      'address': addressController.text,
      'aadharNumber': aadharController.text,
      'dueDate': selectedDueDate.toString().split(' ')[0],
      'trimester': trimesterController.text,
    });

    // Create a document for health details
    await userCollection
        .doc(userId)
        .collection('health details')
        .doc(userId)
        .set({
      'weight': weightController.text,
      'height': heightController.text,
    });

    // Create a document for vaccination details
    await userCollection.doc(userId).collection('vaccination').doc(userId).set({
      'coronaVaccine': coronaVaccineController.text,
      'ttVaccine': ttVaccineController.text,
    });
    assignAshaWorkerToCurrentPregnantWoman(userId);
    // Navigate to the login page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => const LoginPreg()),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : saveForm();
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
