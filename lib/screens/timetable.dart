import 'package:flutter/material.dart';
import 'package:my_first/screens/add_timetable.dart';

class TimeTableScreen extends StatefulWidget {
  @override
  _TimeTableScreenState createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  String selectedClass = "Select Class";

  final List<Map<String, dynamic>> timetableData = [
    {
      "day": "Sunday",
      "subjects": [
        {
          "name": "Mathematics",
          "teacher": "Teacher's Name",
          "time": "8:00 AM - 8:45 AM"
        },
        {
          "name": "Science",
          "teacher": "Teacher's Name",
          "time": "9:00 AM - 9:45 AM"
        },
      ]
    },
    {
      "day": "Monday",
      "subjects": [
        {
          "name": "Mathematics",
          "teacher": "Teacher's Name",
          "time": "9:00 AM - 9:45 AM"
        },
      ]
    },
    {
      "day": "Tuesday",
      "subjects": [
        {
          "name": "Science",
          "teacher": "Teacher's Name",
          "time": "9:00 AM - 9:45 AM"
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Time table", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown & Add Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFf8a35a),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: selectedClass,
                    items: ['Select Class', 'Class 1', 'Class 2', 'Class 3']
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
                    dropdownColor: const Color(0xFFf8a35a),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // Add Timetable Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTimeTableScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.add),
                  label: Text("Time Table"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 21),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: const Color(0xFF14DFB3),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Timetable List
            Expanded(
              child: ListView.builder(
                itemCount: timetableData.length,
                itemBuilder: (context, index) {
                  final dayData = timetableData[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dayData["day"],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Column(
                        children: dayData["subjects"]
                            .map<Widget>(
                                (subject) => TimeTableCard(subject: subject))
                            .toList(),
                      ),
                      SizedBox(height: 12),
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
}

// Timetable Card Widget
class TimeTableCard extends StatelessWidget {
  final Map<String, String> subject;

  TimeTableCard({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Subject Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject["name"]!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "- ${subject["teacher"]}",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 4),
                Text(
                  subject["time"]!,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            // Edit & Delete Icons
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: const Color(0xFFf8a35a)),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
