import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TimetableScreen(),
    );
  }
}

class TimetableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6, // Number of days
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Timetable',
            style: TextStyle(color: Colors.orange),
          ),
          backgroundColor: Colors.white,
          elevation: 4,
          shadowColor: Colors.teal.withOpacity(0.3),
          iconTheme: IconThemeData(color: Colors.black),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Sun'),
              Tab(text: 'Mon'),
              Tab(text: 'Tue'),
              Tab(text: 'Wed'),
              Tab(text: 'Thu'),
              Tab(text: 'Fri'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DaySchedule(day: 'Sunday'),
            DaySchedule(day: 'Monday'),
            DaySchedule(day: 'Tuesday'),
            DaySchedule(day: 'Wednesday'),
            DaySchedule(day: 'Thursday'),
            DaySchedule(day: 'Friday'),
          ],
        ),
      ),
    );
  }
}

class DaySchedule extends StatelessWidget {
  final String day;

  DaySchedule({required this.day});

  @override
  Widget build(BuildContext context) {
    // Sample schedule for demonstration
    final schedule = [
      {
        'time': '6:30 am - 7:30 am',
        'subject': 'Cloud Computing',
        'teacher': 'Sahodar Dhungana',
      },
      {
        'time': '7:30 am - 8:30 am',
        'subject': 'Cyber Law',
        'teacher': 'Prakash Khanal',
      },
    ];

    return ListView.builder(
      itemCount: schedule.length,
      itemBuilder: (context, index) {
        final entry = schedule[index];
        return TimetableEntry(
          time: entry['time']!,
          subject: entry['subject']!,
          teacher: entry['teacher']!,
        );
      },
    );
  }
}

class TimetableEntry extends StatelessWidget {
  final String time;
  final String subject;
  final String teacher;

  TimetableEntry({
    required this.time,
    required this.subject,
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
          BoxShadow(
            color: Colors.teal.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(-4, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Time on the left side
          Container(
            width: 140,
            child: Text(
              time,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(width: 16.0), // Space between time and other details
          
          // Subject and Teacher on the right side
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject, style: TextStyle(fontSize: 14)),
                SizedBox(height: 4.0),
                Text(
                  teacher,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
