import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AddNewSubjectScreen(),
  ));
}

class AddNewSubjectScreen extends StatefulWidget {
  @override
  _AddNewSubjectScreenState createState() => _AddNewSubjectScreenState();
}

class _AddNewSubjectScreenState extends State<AddNewSubjectScreen> {
  String? selectedClass;
  final List<String> classOptions = ['Class 1', 'Class 2', 'Class 3'];
  // List to store subject name and marks controllers dynamically
  List<Map<String, TextEditingController>> subjects = [
    {'subject': TextEditingController(), 'marks': TextEditingController()}
  ]; // One default subject input row

  void addSubjectRow() {
    setState(() {
      subjects.add({
        'subject': TextEditingController(),
        'marks': TextEditingController()
      });
    });
  }

  void removeSubjectRow(int index) {
    if (subjects.length > 1) {
      setState(() {
        subjects.removeAt(index);
      });
    }
  }

  void submitSubjects() {
    for (var subject in subjects) {
      print(
          "Subject: ${subject['subject']!.text}, Marks: ${subject['marks']!.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Subject",
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown for class selection
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Select Class..",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              value: selectedClass,
              items: classOptions.map((String className) {
                return DropdownMenuItem<String>(
                  value: className,
                  child: Text(className),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedClass = newValue;
                });
              },
            ),
            SizedBox(height: 16),
            // Dynamic subject rows inside ListView for scrollable content
            Expanded(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: subjects[index]['subject'],
                                decoration: InputDecoration(
                                  labelText: "Subject Name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: subjects[index]['marks'],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Total Exam Marks",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // Buttons to add/remove subject input rows
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800]),
                        onPressed: addSubjectRow,
                        icon: Icon(Icons.add, color: Colors.white),
                        label: Text("Subject",
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFf8a35a)),
                        onPressed: subjects.length > 1
                            ? () => removeSubjectRow(subjects.length - 1)
                            : null,
                        icon: Icon(Icons.remove),
                        label: Text("Subject"),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 20, 223, 179),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: submitSubjects,
                      icon: Icon(Icons.add),
                      label: Text("Add Subject"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
