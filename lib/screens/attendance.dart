import 'package:flutter/material.dart';

void main() {
  runApp(AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AttendanceScreen(),
    );
  }
}

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String selectedClass = 'Class 1';
  final List<Student> students = [
    Student('Aayush Nepal', 'https://i.pravatar.cc/150?img=1', 'P'),
    Student('Amala Rai', 'https://i.pravatar.cc/150?img=2', 'A'),
    Student('Anala Rai', 'https://i.pravatar.cc/150?img=2', 'A'),
    Student('Bashu Limbu', 'https://i.pravatar.cc/150?img=3', 'L'),
    Student('Basihu Limbu', 'https://i.pravatar.cc/150?img=3', 'L'),
    Student('Dipak Nepal', 'https://i.pravatar.cc/150?img=4', 'P'),
    Student('Kipik Nepal', 'https://i.pravatar.cc/150?img=4', 'P'),
  ];

  void updateAttendance(int index, String status) {
    setState(() {
      students[index].attendance = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Student>> groupedStudents = {};
    for (var student in students) {
      String initial = student.name[0];
      if (!groupedStudents.containsKey(initial)) {
        groupedStudents[initial] = [];
      }
      groupedStudents[initial]!.add(student);
    }

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Attendance', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_today, size: 16),
                    SizedBox(width: 8),
                    Text("Today 09 Dec 2019",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 20, 223, 179),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: selectedClass,
                    items: ['Class 1', 'Class 2', 'Teachers']
                        .map((cls) =>
                            DropdownMenuItem(value: cls, child: Text(cls)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedClass = value!;
                      });
                    },
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    underline: Container(),
                    dropdownColor: const Color.fromARGB(255, 20, 223, 179),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 21),
                    backgroundColor: const Color(0xFFf8a35a),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('Take Attendance'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: groupedStudents.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(entry.key,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      ...entry.value.map((student) => AttendanceCard(
                            student: student,
                            onStatusChange: (status) => updateAttendance(
                                students.indexOf(student), status),
                          )),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Student {
  final String name;

  final String imageUrl;
  String attendance;
  Student(this.name, this.imageUrl, this.attendance);
}

class AttendanceCard extends StatelessWidget {
  final Student student;
  final Function(String) onStatusChange;

  AttendanceCard({required this.student, required this.onStatusChange});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(student.imageUrl)),
        title:
            Text(student.name, style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStatusButton(
                'P', student.attendance, Colors.green, onStatusChange),
            _buildStatusButton(
                'A', student.attendance, Colors.red, onStatusChange),
            _buildStatusButton(
                'L', student.attendance, Colors.orange, onStatusChange),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButton(
      String status, String current, Color color, Function(String) onTap) {
    return GestureDetector(
      onTap: () => onTap(status),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: current == status ? color : Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Text(status,
            style: TextStyle(
                color: current == status ? Colors.white : Colors.black)),
      ),
    );
  }
}
