import 'package:flutter/material.dart';

class MarkSheetScreen extends StatefulWidget {
  @override
  _MarkSheetScreenState createState() => _MarkSheetScreenState();
}

class _MarkSheetScreenState extends State<MarkSheetScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> students = [
    {"name": "Aayush Nepal", "id": "123456"},
    {"name": "Amala Rai", "id": "123457"},
    {"name": "Bishal Tamang", "id": "123458"},
    {"name": "Bishal Rai", "id": "123459"},
    {"name": "Dipak Limbu", "id": "123460"},
  ];

  // Store marks using student ID as the key
  Map<String, Map<String, int>> marks = {};

  List<Map<String, dynamic>> filteredStudents = [];

  String selectedClass = "Class 1";
  String selectedExam = "Midterm";
  String selectedSubject = "Math";

  List<String> classes = ["Class 1", "Class 2", "Class 3"];
  List<String> exams = ["Midterm", "Final"];
  List<String> subjects = ["Math", "Science", "English"];

  @override
  void initState() {
    super.initState();
    filteredStudents = students;

    // Initialize marks with default values (if needed)
    for (var student in students) {
      marks.putIfAbsent(student["id"], () => {"internal": 0, "external": 0});
    }
  }

  void _filterStudents(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredStudents = students;
      } else {
        filteredStudents = students
            .where((student) =>
                student["name"].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Mark Sheet', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildDropdownRow(),
            SizedBox(height: 10),
            buildSearchBar(),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = filteredStudents[index];
                  bool isFirstOfGroup = index == 0 ||
                      student["name"][0] !=
                          filteredStudents[index - 1]["name"][0];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isFirstOfGroup)
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Text(
                            student["name"][0], // Group letter (A, B, etc.)
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      buildStudentCard(student),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdownRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildDropdownButton("Class", selectedClass, classes, (value) {
          setState(() {
            selectedClass = value!;
          });
        }),
        buildDropdownButton("Exam", selectedExam, exams, (value) {
          setState(() {
            selectedExam = value!;
          });
        }),
        buildDropdownButton("Subject", selectedSubject, subjects, (value) {
          setState(() {
            selectedSubject = value!;
          });
        }),
      ],
    );
  }

  Widget buildDropdownButton(String label, String selectedValue,
      List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 20, 223, 179),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        dropdownColor: const Color.fromARGB(255, 20, 223, 179),
        icon: Icon(Icons.arrow_drop_down,
            color: const Color.fromARGB(255, 0, 0, 0)),
        iconSize: 24,
        elevation: 16,
        style:
            TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 16),
        underline: Container(),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget buildSearchBar() {
    return TextField(
      controller: _searchController,
      onChanged: _filterStudents,
      decoration: InputDecoration(
        hintText: "Search Student",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget buildStudentCard(Map<String, dynamic> student) {
    String studentId = student["id"];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/profile1.png"),
              radius: 30,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(student["name"],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("ID: ${student["id"]}",
                      style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
            Column(
              children: [
                Text("Internal", style: TextStyle(fontWeight: FontWeight.bold)),
                buildMarksInput(studentId, "internal"),
              ],
            ),
            SizedBox(width: 10),
            Column(
              children: [
                Text("External", style: TextStyle(fontWeight: FontWeight.bold)),
                buildMarksInput(studentId, "external"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMarksInput(String studentId, String type) {
    return Container(
      width: 50,
      height: 40,
      child: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        onChanged: (value) {
          setState(() {
            marks[studentId]![type] = int.tryParse(value) ?? 0;
          });
        },
        controller: TextEditingController(
          text: marks[studentId]![type]?.toString() ?? "",
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 5),
        ),
      ),
    );
  }
}
