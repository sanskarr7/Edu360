import 'package:flutter/material.dart';
import 'assignment_screen.dart';  // Import AssignmentScreen
import 'library_screen.dart';    // Import LibraryScreen
import 'results_screen.dart';    // Import ResultsScreen
import 'change_profile_screen.dart';  // Import ChangeProfileScreen
import 'notice_screen.dart';    // Import NoticeScreen (newly added)
import 'attendance_screen.dart';  // Import AttendanceScreen
import '../widgets/grid_item.dart'; // Import the reusable widget
import 'subjects_screen.dart';  // Import SubjectsScreen for subject navigation
import 'timetable_screen.dart';  // Import TimetableScreen

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Current selected index for bottom navigation
  int _currentIndex = 0;

  // List of screens for navigation
  final List<Widget> _screens = [
    HomePageContent(),
    NoticeScreen(),  // Corrected the use of the NoticeScreen class
    CalendarPage(),
    SettingsScreen(),  // Corrected to use the SettingsScreen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          'Edu360',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.notifications, color: Colors.white),
          )
        ],
      ),
      body: _screens[_currentIndex],  // Display the screen based on selected index
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notice'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,  // Highlight selected index
        onTap: (index) {
          setState(() {
            _currentIndex = index;  // Update the selected index
          });
        },
      ),
    );
  }
}

// Home page content (profile card and grid items)
class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeProfileScreen(),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.teal[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Sanskar Satyal',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'sanskarsatyal99@gmail.com',
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Reliance College',
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '9748274572',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.count(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              GridItem(
                icon: Icons.calendar_today,
                label: 'Attendance',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendanceScreen(),
                    ),
                  );
                },
              ),
              GridItem(
                icon: Icons.schedule,
                label: 'Time Table',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TimetableScreen(),  // Navigate to TimetableScreen
                    ),
                  );
                },
              ),
              GridItem(
                icon: Icons.library_books,
                label: 'Library',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LibraryScreen(),
                    ),
                  );
                },
              ),
              GridItem(
                icon: Icons.money,
                label: 'Fee',
              ),
              GridItem(
                icon: Icons.directions_bus,
                label: 'Bus',
              ),
              GridItem(
                icon: Icons.assignment,
                label: 'Assignment',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssignmentScreen(),
                    ),
                  );
                },
              ),
              GridItem(
                icon: Icons.book,
                label: 'Subjects',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubjectsScreen(),
                    ),
                  );
                },
              ),
              GridItem(
                icon: Icons.school,
                label: 'Exam',
              ),
              GridItem(
                icon: Icons.grade,
                label: 'Result',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Placeholder Screens for Calendar, and Settings
class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Calendar Page"));
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Leave'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Online Meeting'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('About Us'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
