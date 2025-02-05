import 'package:flutter/material.dart';
import 'package:my_first/screens/add_exam_routine.dart';

void main() {
  runApp(MaterialApp(
    home: ExamRoutineScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class ExamRoutineScreen extends StatefulWidget {
  @override
  _ExamRoutineScreenState createState() => _ExamRoutineScreenState();
}

class _ExamRoutineScreenState extends State<ExamRoutineScreen> {
  String selectedClass = "Select Class";
  String selectedExam = "Select Exam";

  List<ExamRoutine> examRoutines = [
    ExamRoutine("First Term Exam", "01/01/2025", 5, [
      SubjectDetail("Science", 75, "01/01"),
      SubjectDetail("Nepali", 75, "01/02"),
      SubjectDetail("Math", 100, "01/03"),
      SubjectDetail("Social", 75, "01/04"),
      SubjectDetail("English", 75, "01/05"),
    ]),
    ExamRoutine("First Term Exam", "01/01/2025", 2, [
      SubjectDetail("Science", 75, "01/01"),
      SubjectDetail("Nepali", 75, "01/02"),
      SubjectDetail("Math", 100, "01/03"),
      SubjectDetail("Social", 75, "01/04"),
      SubjectDetail("English", 75, "01/05"),
    ]),
  ];

  void addNewExam() {
    print("Add New Exam");
  }

  void editExam(ExamRoutine exam) {
    print("Edit ${exam.examTitle}");
  }

  void deleteExam(ExamRoutine exam) {
    setState(() {
      examRoutines.remove(exam);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Exam Routine", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Class Dropdown
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFf8a35a), // Light yellow background
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: DropdownButton<String>(
                    value: selectedClass,
                    onChanged: (value) {
                      setState(() {
                        selectedClass = value!;
                      });
                    },
                    items: ["Select Class", "Class 1", "Class 2", "Class 3"]
                        .map((className) => DropdownMenuItem(
                              value: className,
                              child: Text(
                                className,
                                style: TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    style: TextStyle(color: Colors.black),
                    dropdownColor: const Color(0xFFf8a35a), // Yellow dropdown
                    underline: Container(), // Remove default underline
                    icon: Icon(Icons.arrow_drop_down,
                        color: const Color.fromARGB(255, 0, 0, 0)),
                    iconSize: 30,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                // Exam Dropdown
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFf8a35a), // Light yellow background
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: DropdownButton<String>(
                    value: selectedExam,
                    onChanged: (value) {
                      setState(() {
                        selectedExam = value!;
                      });
                    },
                    items: ["Select Exam", "Mid-Term", "Final Exam"]
                        .map((exam) => DropdownMenuItem(
                              value: exam,
                              child: Text(
                                exam,
                                style: TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    style: TextStyle(color: Colors.black),
                    dropdownColor: const Color(0xFFf8a35a), // Yellow dropdown
                    underline: Container(), // Remove default underline
                    icon: Icon(Icons.arrow_drop_down,
                        color: const Color.fromARGB(255, 0, 0, 0)),
                    iconSize: 30,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddExaminationScreen()),
                );
              },
              icon: Icon(Icons.add, color: Colors.black),
              label:
                  Text("Add New Exam", style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                backgroundColor: const Color.fromARGB(255, 20, 223, 179),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
            SizedBox(height: 12.0),
            Expanded(
              child: ListView.builder(
                itemCount: examRoutines.length,
                itemBuilder: (context, index) {
                  final exam = examRoutines[index];
                  return ExamCard(
                    exam: exam,
                    onEdit: () => editExam(exam),
                    onDelete: () => _confirmDelete(context, exam),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Confirmation dialog for delete
  void _confirmDelete(BuildContext context, ExamRoutine exam) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this exam routine?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                deleteExam(exam); // Delete the exam routine
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

class ExamRoutine {
  final String examTitle;
  final String examDate;
  final int classNumber;
  final List<SubjectDetail> subjects;

  ExamRoutine(this.examTitle, this.examDate, this.classNumber, this.subjects);
}

class SubjectDetail {
  final String subjectName;
  final int totalMarks;
  final String startDate;

  SubjectDetail(this.subjectName, this.totalMarks, this.startDate);
}

class ExamCard extends StatelessWidget {
  final ExamRoutine exam;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  ExamCard({required this.exam, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      margin: EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
            color: const Color.fromARGB(255, 0, 0, 0)), // Border color added
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  exam.examTitle,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 12, 12, 12)),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: const Color(0xFFf8a35a)),
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
            Text(exam.examDate,
                style: TextStyle(
                    fontSize: 14.0, color: const Color.fromARGB(255, 0, 0, 0))),
            SizedBox(height: 8.0),
            Text("Class ${exam.classNumber}",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0))),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                children: [
                  Table(
                    border: TableBorder.symmetric(
                        inside: BorderSide(
                            width: 1,
                            color: const Color.fromARGB(255, 0, 0, 0))),
                    children: [
                      TableRow(
                        decoration:
                            BoxDecoration(color: const Color(0xFFf8a35a)),
                        children: [
                          _buildTableCell("Subjects", true),
                          _buildTableCell("Total Marks", true),
                          _buildTableCell("Start Date", true),
                        ],
                      ),
                      ...exam.subjects.map(
                        (subject) => TableRow(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 20, 223, 179)),
                          children: [
                            _buildTableCell(subject.subjectName, false),
                            _buildTableCell(
                                subject.totalMarks.toString(), false),
                            _buildTableCell(subject.startDate, false),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableCell(String text, bool isHeader) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: isHeader ? 16.0 : 14.0,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}
