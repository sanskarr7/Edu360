import 'package:flutter/material.dart';
import 'leave_note_screen.dart'; // Import the LeaveNoteScreen

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Leave'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to LeaveNoteScreen when the Leave option is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeaveNoteScreen()),
                );
              },
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
      ),
    );
  }
}
