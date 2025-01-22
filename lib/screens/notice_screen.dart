import 'package:flutter/material.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  // Simulate fetching data from a database
  // Replace this method with an actual database query when connecting to a real database (e.g., Firebase, SQLite, etc.)
  Future<List<Map<String, String>>> fetchNotices() async {
    // Simulating network/database delay (remove when using a real database)
    await Future.delayed(const Duration(seconds: 2));

    // Example dynamic data simulating a "database"
    return [
      {
        'title': 'Important Notice Regarding College Timing',
        'description': 'The new timing for the college has been updated. Please check the attached schedule.',
        'date': '20/01/2025',
      },
      {
        'title': 'Examination Schedule Released',
        'description': 'The examination schedule for the upcoming semester has been released. Check the notice board.',
        'date': '19/01/2025',
      },
      {
        'title': 'Holiday Notice for National Day',
        'description': 'All classes are canceled on the occasion of National Day.',
        'date': '18/01/2025',
      },
      {
        'title': 'Library Closed for Maintenance',
        'description': 'The library will be closed for maintenance from 20/01 to 22/01. Please plan accordingly.',
        'date': '17/01/2025',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List<Map<String, String>>>(
        future: fetchNotices(), // Simulate database fetch, replace with real call
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notices available.'));
          }

          // Dynamically display the notices and header
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dynamic Heading 'NOTICE'
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: Text(
                    'NOTICE',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
              ),
              // Displaying dynamic notices from the database
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    var notice = snapshot.data![index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // Handle tap event, you can show details or navigate to a detailed view
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0), // Reduced padding
                              child: Row(
                                children: [
                                  // Icon for Notice
                                  const Icon(
                                    Icons.notifications,
                                    size: 30,
                                    color: Colors.orangeAccent,
                                  ),
                                  const SizedBox(width: 10),
                                  // Notice details in a smaller size container
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Notice Title (dynamic from database)
                                        Text(
                                          notice['title']!,
                                          style: const TextStyle(
                                            fontSize: 14,  // Reduced font size for title
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5),
                                        // Notice Description (dynamic from database)
                                        Text(
                                          notice['description']!,
                                          style: const TextStyle(
                                            fontSize: 12, // Reduced font size for description
                                            color: Colors.black87,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5),
                                        // Notice Date (dynamic from database)
                                        Text(
                                          'Date: ${notice['date']}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
