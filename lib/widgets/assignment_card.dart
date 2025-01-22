import 'package:flutter/material.dart';

class AssignmentCard extends StatelessWidget {
  final String subject;
  final String title;
  final String dueDate;
  final String dueTime;
  final IconData icon;
  final Widget? trailing; // Add trailing parameter

  AssignmentCard({
    required this.subject,
    required this.title,
    required this.dueDate,
    required this.dueTime,
    required this.icon,
    this.trailing, // Make trailing parameter optional
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(title),
        subtitle: Text('$subject\nDue: $dueTime'),
        trailing: trailing, // Use the trailing parameter here
      ),
    );
  }
}
