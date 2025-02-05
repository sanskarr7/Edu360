import 'package:flutter/material.dart';
import 'package:my_first/screens/add_teacher.dart';

class TeacherScreen extends StatelessWidget {
  final List<Map<String, String>> teachers = [
    {
      'name': 'Ram Nepal',
      'email': 'ran@gmail.com',
      'image':
          'https://i.pinimg.com/originals/8d/b7/f6/8db7f6a91935bc5bbfd84a71fefcfd18.jpg'
    },
    {
      'name': 'Hari Kaliz',
      'email': 'ran@gmail.com',
      'image':
          'https://i.pinimg.com/originals/a3/7b/e5/a37be5b9709175f1527761157463ec38.jpg'
    },
    {
      'name': 'Gopal Kafle',
      'email': 'ran@gmail.com',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeM_uVhUxuWMjezl0rV0KPIad0chGa4Pw6aA&s'
    },
    {
      'name': 'Nayan Tamang',
      'email': 'ran@gmail.com',
      'image':
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjPWQTnePNQOhGoSq8Sv0hdxWo0QOU_Ys-6djgmxz3f7vYE_QqTANwmbRCU7TADxAQ6-dedxQ07miTw15vMFfBqOPxrZTid5BtVW8d55uP4Rl_z4jpHGUD8VjktnfAo5RMdLQ0ai7wJwOI/s570/Shazim+uddin+pp+image+with+stroke.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teachers', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Find Teacher..',
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFf8a35a),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    elevation: 1,
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
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    underline: Container(),
                    dropdownColor: const Color(0xFFf8a35a),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Spacer(),
                // Add button
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Add'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 21),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: const Color(0xFF14DFB3),
                  ),
                  onPressed: () {
                    // Navigate to AddTeacherScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTeacherScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Teacher list
            Expanded(
              child: ListView.builder(
                itemCount: teachers.length,
                itemBuilder: (context, index) {
                  final teacher = teachers[index];
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
                            backgroundImage: NetworkImage(teacher['image']!),
                            radius: 30.0,
                          ),
                          SizedBox(width: 20.0),
                          // Name and email
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  teacher['name']!,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  teacher['email']!,
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
                            icon: Icon(Icons.edit,
                                color: const Color(0xFFf8a35a)),
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
                                        'Are you sure you want to Delete this Teacher Record?'),
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
