import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(
          'Calendar Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}