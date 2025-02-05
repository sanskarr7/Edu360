import 'package:flutter/material.dart';
import 'package:my_first/screens/add_subject.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ClassesWithSubjectsScreen(),
  ));
}

class ClassesWithSubjectsScreen extends StatefulWidget {
  @override
  _ClassesWithSubjectsScreenState createState() =>
      _ClassesWithSubjectsScreenState();
}

class _ClassesWithSubjectsScreenState extends State<ClassesWithSubjectsScreen> {
  TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> classes = [
    {
      'className': 'Class 1',
      'subjects': [
        {'name': 'Science', 'marks': 75},
        {'name': 'Nepali', 'marks': 75},
        {'name': 'Math', 'marks': 100},
        {'name': 'English', 'marks': 75},
        {'name': 'Social', 'marks': 75},
      ]
    },
    {
      'className': 'Class 2',
      'subjects': [
        {'name': 'Science', 'marks': 75},
        {'name': 'Nepali', 'marks': 75},
        {'name': 'Math', 'marks': 100},
        {'name': 'English', 'marks': 75},
        {'name': 'Social', 'marks': 75},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text(
            'Classes With Subjects',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Find Class..',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Colors.yellow, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Colors.yellow, width: 2),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNewSubjectScreen()),
                );
              },
              icon: Icon(Icons.add),
              label: Text('Add New Subjects'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 20, 223, 179),
                foregroundColor: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  return ClassCard(classes[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClassCard extends StatelessWidget {
  final Map<String, dynamic> classData;
  ClassCard(this.classData);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  classData['className'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit, color: const Color(0xFFf8a35a))),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete, color: Colors.red)),
                  ],
                )
              ],
            ),
            Text(
              '${classData['subjects'].length} SUBJECTS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(classData['subjects'].length, (i) {
                final subject = classData['subjects'][i];
                return SubjectCard(subject);
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final Map<String, dynamic> subject;
  SubjectCard(this.subject);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            subject['name'],
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            'Marks: ${subject['marks']}',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
