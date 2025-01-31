import 'package:flutter/material.dart';
import 'package:my_first/screens/assignment.dart';
import 'package:my_first/screens/notice.dart';
import 'package:my_first/screens/student_screen.dart';
import 'teacher_screen.dart'; // Import the TeacherScreen

class MenuScreen extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.group, 'title': 'Students'},
    {'icon': Icons.person, 'title': 'Teachers'},
    {'icon': Icons.school, 'title': 'Learning'},
    {'icon': Icons.assignment, 'title': 'Assignment'},
    {'icon': Icons.assessment, 'title': 'Assessment'},
    {'icon': Icons.bar_chart, 'title': 'Attendance'},
    {'icon': Icons.book, 'title': 'Subjects'},
    {'icon': Icons.attach_money, 'title': 'Payments'},
    {'icon': Icons.schedule, 'title': 'Timetable'},
    {'icon': Icons.notifications_none, 'title': 'Notices'},
    {'icon': Icons.settings, 'title': 'Settings'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          if (item['title'] == 'Learning') {
            // Use ExpansionTile for the "Learning" item
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ExpansionTile(
                leading: Icon(item['icon'], size: 30.0, color: Colors.blueGrey),
                title: Text(item['title'], style: TextStyle(fontSize: 16.0)),
                children: [
                  // Sub-options for "Learning"
                  ListTile(
                    leading: Icon(Icons.book, size: 24.0, color: Colors.grey),
                    title: Text('Curriculum'),
                    onTap: () {
                      // Navigate to Curriculum screen or perform an action
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.sports_soccer,
                        size: 24.0, color: Colors.grey),
                    title: Text('Co-curricular'),
                    onTap: () {
                      // Navigate to Co-curricular screen or perform an action
                    },
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.music_note, size: 24.0, color: Colors.grey),
                    title: Text('Extracurricular'),
                    onTap: () {
                      // Navigate to Extracurricular screen or perform an action
                    },
                  ),
                ],
              ),
            );
          } else {
            // Regular ListTile for other items
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                leading: Icon(item['icon'], size: 30.0, color: Colors.blueGrey),
                title: Text(item['title'], style: TextStyle(fontSize: 16.0)),
                trailing: Icon(Icons.arrow_forward_ios,
                    size: 16.0, color: Colors.grey),
                onTap: () {
                  if (item['title'] == 'Teachers') {
                    // Navigate to TeacherScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeacherScreen(),
                      ),
                    );
                  } else if (item['title'] == 'Students') {
                    // Navigate to StudentScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentScreen(),
                      ),
                    );
                  } else if (item['title'] == 'Notices') {
                    // Navigate to StudentScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoticeBoardScreen(),
                      ),
                    );
                  } else if (item['title'] == 'Assignment') {
                    // Navigate to StudentScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AssignmentApp(),
                      ),
                    );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}
