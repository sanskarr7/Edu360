import 'package:flutter/material.dart';
import '../widgets/assignment_card.dart';
import '../widgets/filter_chips.dart';
import 'assignment_details_screen.dart'; // Import the new screen for assignment details

class AssignmentScreen extends StatefulWidget {
  @override
  _AssignmentScreenState createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  String selectedFilter = 'All Subjects'; // Initial filter

  // Static List of assignments with an added 'isSubmitted' field
  final List<Map<String, dynamic>> assignments = [
    {'subject': 'Math', 'title': 'Assignment 1', 'dueDate': '20-12-2024', 'dueTime': '2 January 2025, 10:15 PM', 'icon': Icons.calculate, 'isSubmitted': false},
    {'subject': 'Account', 'title': 'Final Account', 'dueDate': '21-12-2024', 'dueTime': '1 January 2025, 10:15 PM', 'icon': Icons.book, 'isSubmitted': false},
    {'subject': 'Science', 'title': 'Pressure', 'dueDate': '22-12-2024', 'dueTime': '2 January 2025, 10:15 PM', 'icon': Icons.science, 'isSubmitted': true},
    {'subject': 'Computer Science', 'title': 'Operating System', 'dueDate': '23-12-2024', 'dueTime': '2 January 2025, 10:15 PM', 'icon': Icons.computer, 'isSubmitted': true},
    {'subject': 'Math', 'title': 'Assignment 2', 'dueDate': '24-12-2024', 'dueTime': '9 January 2025, 10:15 PM', 'icon': Icons.calculate, 'isSubmitted': false},
  ];

  // TODO: Replace the static list with dynamic assignments fetched from API or database
  // List<Map<String, dynamic>> assignments = fetchAssignmentsFromAPI();

  // Filter the assignments based on the selected filter
  List<Map<String, dynamic>> get filteredAssignments {
    if (selectedFilter == 'All Subjects') {
      return assignments;
    }
    return assignments.where((assignment) => assignment['subject'] == selectedFilter).toList();
  }

  // Filter assignments based on submission status
  List<Map<String, dynamic>> get filteredAssignmentsByStatus {
    return filteredAssignments.where((assignment) => assignment['isSubmitted'] == true).toList();
  }

  // Function to submit an assignment
  void submitAssignment(int index) {
    setState(() {
      assignments[index]['isSubmitted'] = true; // Mark as submitted
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Assignments',
            style: TextStyle(color: Colors.orange),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          bottom: TabBar(
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Assigned'),
              Tab(text: 'Submitted'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Assigned tab - displays all filtered assignments
            Column(
              children: [
                FilterChips(
                  onFilterSelected: (filter) {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredAssignments.length,
                    itemBuilder: (context, index) {
                      final assignment = filteredAssignments[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to Assignment Details Screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AssignmentDetailsScreen(assignment: assignment),
                            ),
                          );
                        },
                        child: AssignmentCard(
                          subject: assignment['subject']!,
                          title: assignment['title']!,
                          dueDate: assignment['dueDate']!,
                          dueTime: assignment['dueTime']!,
                          icon: assignment['icon']!,
                          // Add Submit button on the card
                          trailing: IconButton(
                            icon: Icon(Icons.check_circle, color: assignment['isSubmitted'] ? Colors.green : Colors.grey),
                            onPressed: () => submitAssignment(index),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            // Submitted tab - displays only submitted assignments
            Column(
              children: [
                FilterChips(
                  onFilterSelected: (filter) {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredAssignmentsByStatus.length,
                    itemBuilder: (context, index) {
                      final assignment = filteredAssignmentsByStatus[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to Assignment Details Screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AssignmentDetailsScreen(assignment: assignment),
                            ),
                          );
                        },
                        child: AssignmentCard(
                          subject: assignment['subject']!,
                          title: assignment['title']!,
                          dueDate: assignment['dueDate']!,
                          dueTime: assignment['dueTime']!,
                          icon: assignment['icon']!,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
