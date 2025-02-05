import 'package:flutter/material.dart';

class AddTimeTableScreen extends StatefulWidget {
  @override
  _AddTimeTableScreenState createState() => _AddTimeTableScreenState();
}

class _AddTimeTableScreenState extends State<AddTimeTableScreen> {
  String? selectedClass;
  String? selectedDay;
  String? selectedTeacher;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  final List<String> classOptions = ["Class 1", "Class 2", "Class 3"];
  final List<String> dayOptions = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  final List<String> teacherOptions = ["Teacher A", "Teacher B", "Teacher C"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Timetable",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Class Dropdown
            buildDropdown("Select Class", selectedClass, classOptions, (value) {
              setState(() {
                selectedClass = value;
              });
            }),
            SizedBox(height: 10),

            // Day & Teacher Dropdowns (Side by Side)
            Row(
              children: [
                Expanded(
                  child: buildDropdown("Select Day", selectedDay, dayOptions,
                      (value) {
                    setState(() {
                      selectedDay = value;
                    });
                  }),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: buildDropdown(
                      "Select Teacher", selectedTeacher, teacherOptions,
                      (value) {
                    setState(() {
                      selectedTeacher = value;
                    });
                  }),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Title & Time Fields (Side by Side)
            Row(
              children: [
                Expanded(
                  child: buildTextField("Title", titleController),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: buildTextField("Time (00 - 00)", timeController),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Add Timetable Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add Timetable Logic
                },
                icon: Icon(Icons.add),
                label: Text("Add Timetable"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dropdown Widget
  Widget buildDropdown(String hint, String? value, List<String> items,
      Function(String?) onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: SizedBox(),
        hint: Text(hint),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  // TextField Widget
  Widget buildTextField(String hint, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
      ),
    );
  }
}
