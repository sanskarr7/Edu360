import 'package:flutter/material.dart';
import 'package:my_first/screens/add_student.dart';

class StudentScreen extends StatelessWidget {
  final List<Map<String, String>> students = [
    {
      'name': 'Ram Nepal',
      'registration_no': '12345',
      'image':
          'https://i.pinimg.com/originals/8d/b7/f6/8db7f6a91935bc5bbfd84a71fefcfd18.jpg'
    },
    {
      'name': 'Hari Kaliz',
      'registration_no': '12345',
      'image':
          'https://i.pinimg.com/originals/a3/7b/e5/a37be5b9709175f1527761157463ec38.jpg'
    },
    {
      'name': 'Gopal Kafle',
      'registration_no': '12345',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeM_uVhUxuWMjezl0rV0KPIad0chGa4Pw6aA&s'
    },
    {
      'name': 'Nayan Tamang',
      'registration_no': '12345',
      'image':
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjPWQTnePNQOhGoSq8Sv0hdxWo0QOU_Ys-6djgmxz3f7vYE_QqTANwmbRCU7TADxAQ6-dedxQ07miTw15vMFfBqOPxrZTid5BtVW8d55uP4Rl_z4jpHGUD8VjktnfAo5RMdLQ0ai7wJwOI/s570/Shazim+uddin+pp+image+with+stroke.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Find Student..',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16.0),

            // Filter and Add buttons
            Row(
              children: [
                // Filter button
                DropdownButton<String>(
                  elevation: 16,
                  value: 'All',
                  items: ['All', 'Class 1', 'Class 2', 'Class 3']
                      .map((String category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    // Handle filter change
                  },
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  dropdownColor: Colors.grey[200],
                ),
                Spacer(),
                // Add button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddStudentScreen(),
                      ),
                    ); // Handle add action
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: Colors.yellow[700],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Student list
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // Profile picture
                          CircleAvatar(
                            backgroundImage: NetworkImage(student['image']!),
                            radius: 30.0,
                          ),
                          SizedBox(width: 20.0),
                          // Name and registration_no
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  student['name']!,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  student['registration_no']!,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Action buttons
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.yellow[700]),
                            onPressed: () {
                              // Handle edit action
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirm Delete',
                                        style: TextStyle(color: Colors.red)),
                                    content: Text(
                                        'Are you sure you want to Delete this Student Record ?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text('Cancel',
                                            style:
                                                TextStyle(color: Colors.grey)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Handle delete action here
                                          Navigator.of(context)
                                              .pop(); // Close the dialog after deletion
                                        },
                                        child: Text('Delete',
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
