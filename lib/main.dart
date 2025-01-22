import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/change_profile_screen.dart';
import 'screens/leave_note_screen.dart';
import 'screens/library_screen.dart';
import 'screens/results_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/changeProfile': (context) => ChangeProfileScreen(),
        '/leaveNote': (context) => LeaveNoteScreen(),
        '/library': (context) => LibraryScreen(),
        '/results': (context) => ResultsScreen(),
      },
    );
  }
}
