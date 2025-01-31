// dashboard_page.dart
import 'package:flutter/material.dart';
import 'screens/change_profile_screen.dart';
import 'screens/leave_note_screen.dart';
import 'screens/library_screen.dart';
import 'screens/results_screen.dart';
import 'screens/notice_screen.dart';
import 'screens/attendance_screen.dart';
import 'screens/subjects_screen.dart';
import 'screens/timetable_screen.dart';
import 'screens/assignment_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/grid_item.dart';
import './login_page.dart';
import 'screens/calender_screen.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    _DashboardContent(),
    NoticeScreen(),
    CalendarScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          AppLocalizations.of(context)!.appTitle, // Localized app name
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.home, // Localized "Home"
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications),
            label: AppLocalizations.of(context)!.notice, // Localized "Notice"
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today),
            label: AppLocalizations.of(context)!.calendar, // Localized "Calendar"
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: AppLocalizations.of(context)!.settings, // Localized "Settings"
          ),
        ],
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final email = user?.email ?? 'No email found';
    return Column(
      children: [
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/changeProfile');
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
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sanskar Satyal',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      email,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      AppLocalizations.of(context)!.profileCollege,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '9748274572',
                      style: const TextStyle(color: Colors.white70),
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
                label: AppLocalizations.of(context)!.attendance,
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
                label: AppLocalizations.of(context)!.timetable,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TimetableScreen(),
                    ),
                  );
                },
              ),
              GridItem(
                icon: Icons.library_books,
                label: AppLocalizations.of(context)!.library,
                onTap: () {
                  Navigator.pushNamed(context, '/library');
                },
              ),
              GridItem(
                icon: Icons.money,
                label: AppLocalizations.of(context)!.fee,
                onTap: () {},
              ),
              GridItem(
                icon: Icons.directions_bus,
                label: AppLocalizations.of(context)!.bus,
                onTap: () {},
              ),
              GridItem(
                icon: Icons.assignment,
                label: AppLocalizations.of(context)!.assignment,
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
                label: AppLocalizations.of(context)!.subjects,
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
                label: AppLocalizations.of(context)!.exam,
                onTap: () {},
              ),
              GridItem(
                icon: Icons.grade,
                label: AppLocalizations.of(context)!.result,
                onTap: () {
                  Navigator.pushNamed(context, '/results');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class CalendarPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(AppLocalizations.of(context)!.calendar),
//     );
//   }
// }

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.leave),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, '/leaveNote');
            },
          ),
          const Divider(height: 1),
          ListTile(
            title: Text(AppLocalizations.of(context)!.onlineMeeting),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            title: Text(AppLocalizations.of(context)!.aboutUs),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            title:  Text(AppLocalizations.of(context)!.logout),
            trailing: const Icon(Icons.exit_to_app),
            onTap: () async {
              await Supabase.instance.client.auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage(onLocaleChange: (Locale ) {  },)),
              );
            },
          ),
        ],
      ),
    );
  }
}
