import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: AddExaminationScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class AddExaminationScreen extends StatefulWidget {
  @override
  _AddExaminationScreenState createState() => _AddExaminationScreenState();
}

class _AddExaminationScreenState extends State<AddExaminationScreen> {
  final TextEditingController examNameController = TextEditingController();
  DateTime? startDate;
  String? selectedClass;
  List<Map<String, dynamic>> subjects = [
    {'subject': null, 'marks': TextEditingController(), 'date': null}
  ]; // One default subject row

  void _selectDate(
      BuildContext context, Function(DateTime) onDateSelected) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  void _addSubject() {
    setState(() {
      subjects.add(
          {'subject': null, 'marks': TextEditingController(), 'date': null});
    });
  }

  void _removeSubject() {
    if (subjects.length > 1) {
      setState(() {
        subjects.removeLast();
      });
    }
  }

  void _submitExam() {
    print("Exam Added: ${examNameController.text}");
    print("Class: $selectedClass");
    print("Subjects: $subjects");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Examination",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: examNameController,
              decoration: InputDecoration(
                labelText: "Examination Name",
                prefixIcon: Icon(Icons.book),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(
                        context, (date) => setState(() => startDate = date)),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: "Start Date",
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      child: Text(startDate == null
                          ? "Select Date"
                          : "${startDate!.toLocal()}".split(' ')[0]),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedClass,
                    decoration: InputDecoration(
                      labelText: "Select Class",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                    items: ["Class 1", "Class 2", "Class 3"].map((className) {
                      return DropdownMenuItem(
                          value: className, child: Text(className));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedClass = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Dynamic Subject Rows with Buttons Below
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      for (int index = 0; index < subjects.length; index++) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: subjects[index]['subject'],
                                  decoration: InputDecoration(
                                    labelText: "Subject",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                  ),
                                  items: [
                                    "Science",
                                    "Math",
                                    "English",
                                    "Nepali"
                                  ].map((subject) {
                                    return DropdownMenuItem(
                                        value: subject, child: Text(subject));
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      subjects[index]['subject'] = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: subjects[index]['marks'],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "Total Marks",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: InkWell(
                                  onTap: () => _selectDate(
                                      context,
                                      (date) => setState(() =>
                                          subjects[index]['date'] = date)),
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: "Date",
                                      prefixIcon: Icon(Icons.calendar_today),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                    ),
                                    child: Text(subjects[index]['date'] == null
                                        ? "Select Date"
                                        : "${subjects[index]['date'].toLocal()}"
                                            .split(' ')[0]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      SizedBox(height: 10),

                      // Buttons below subject rows
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _addSubject,
                              icon: Icon(Icons.add, color: Colors.white),
                              label: Text("Add Subject"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: subjects.length > 1
                                  ? _removeSubject
                                  : null, // Disable button if only one row
                              icon: Icon(Icons.remove, color: Colors.white),
                              label: Text("Remove Subject"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: subjects.length > 1
                                    ? const Color(0xFFf8a35a)
                                    : Colors.grey, // Disable color if 1 row
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: _submitExam,
                        icon: Icon(Icons.add, color: Colors.black),
                        label: Text("Add Examination",
                            style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          backgroundColor:
                              const Color.fromARGB(255, 20, 223, 179),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
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
}
