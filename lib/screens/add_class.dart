import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first/screens/class.dart';

void main() {
  runApp(addClassScreen());
}

class addClassScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddNewClassScreen(),
    );
  }
}

class AddNewClassScreen extends StatefulWidget {
  @override
  _AddNewClassScreenState createState() => _AddNewClassScreenState();
}

class _AddNewClassScreenState extends State<AddNewClassScreen> {
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController monthlyFeesController = TextEditingController();
  String? selectedClassTeacher;

  List<String> classTeacherOptions = [
    'Teacher A',
    'Teacher B',
    'Teacher C'
  ]; // Example options

  void addClass() {
    // Implement logic to add a new class
    print('Class Name: ${classNameController.text}');
    print('Monthly Fees: ${monthlyFeesController.text}');
    print('Selected Class Teacher: $selectedClassTeacher');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Class',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ClassScreen()),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: classNameController,
              decoration: InputDecoration(
                labelText: 'Class Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: monthlyFeesController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                labelText: 'Monthly Fees',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Class Teacher...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              value: selectedClassTeacher,
              hint: Text('Select Class Teacher...'),
              items: classTeacherOptions
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedClassTeacher = newValue;
                });
              },
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: addClass,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8.0),
                  Text('Add Class', style: TextStyle(fontSize: 16.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
