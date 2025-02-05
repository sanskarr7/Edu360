import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class AddAssignmentScreen extends StatefulWidget {
  const AddAssignmentScreen({super.key});

  @override
  State<AddAssignmentScreen> createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? setBy; // Make nullable for hint text
  String? selectedClass; // Make nullable for hint text
  String? subject; // Make nullable for hint text
  DateTime? assignmentDate; // Make nullable for no selection
  TextEditingController assignmentDetailController = TextEditingController();

  List<String> setByOptions = [
    'Admin',
    'Teacher1',
    'Teacher2'
  ]; // Example options
  List<String> classOptions = [
    'Class 5',
    'Class 6',
    'Class 7'
  ]; // Example options
  List<String> subjectOptions = [
    'English',
    'Math',
    'Science'
  ]; // Example options

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Assignment',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // For scrollability if content overflows
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Set By Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Set by...',
                    border: OutlineInputBorder(), // Add border
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.person),
                  ),
                  value: setBy,
                  hint: const Text('Set by...'), // Hint text
                  items: setByOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      setBy = newValue;
                    });
                  },
                  validator: (value) => value == null
                      ? 'Please select who set it'
                      : null, // Validation
                ),
                const SizedBox(height: 16),
                // Select Class Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select Class...',
                    border: OutlineInputBorder(), // Add border
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.school),
                  ),
                  value: selectedClass,
                  hint: const Text('Select Class...'), // Hint text
                  items: classOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedClass = newValue;
                    });
                  },
                  validator: (value) => value == null
                      ? 'Please select a class'
                      : null, // Validation
                ),
                const SizedBox(height: 16),
                // Subject Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Subject...',
                    border: OutlineInputBorder(), // Add border
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.book),
                  ),
                  value: subject,
                  hint: const Text('Subject...'), // Hint text
                  items: subjectOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      subject = newValue;
                    });
                  },
                  validator: (value) => value == null
                      ? 'Please select a subject'
                      : null, // Validation
                ),
                const SizedBox(height: 16),
                // Assignment Date Picker
                InkWell(
                  // Use InkWell for tap functionality
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: assignmentDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != assignmentDate) {
                      setState(() {
                        assignmentDate = picked;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          assignmentDate != null
                              ? DateFormat('yyyy-MM-dd')
                                  .format(assignmentDate!) // Format date
                              : 'Assignment Date',
                          style: TextStyle(
                              color: assignmentDate != null
                                  ? Colors.black
                                  : Colors.grey),
                        ),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Assignment Detail Text Field
                TextFormField(
                  controller: assignmentDetailController,
                  decoration: InputDecoration(
                    alignLabelWithHint: true, // Align label with the top
                    labelText: 'Assignment Detail...',
                    border: OutlineInputBorder(), // Add border
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 6, // Allow multiple lines
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter details'
                      : null, // Validation
                ),
                const SizedBox(height: 32),
                // Add Button
                Center(
                  // Center the button
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Form is valid, proceed with adding assignment
                        debugPrint('Set By: $setBy');
                        debugPrint('Class: $selectedClass');
                        debugPrint('Subject: $subject');
                        debugPrint('Date: $assignmentDate');
                        debugPrint(
                            'Details: ${assignmentDetailController.text}');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 20, 223, 179),
                      foregroundColor:
                          const Color.fromARGB(255, 22, 22, 22), // White text
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12), // Adjust padding
                    ),
                    child: const Text('+ Add', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
