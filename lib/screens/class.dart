import 'package:flutter/material.dart';
import 'package:my_first/screens/add_class.dart';

class ClassScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Directly return AllClassesScreen without wrapping it in MaterialApp
    return AllClassesScreen();
  }
}

class AllClassesScreen extends StatefulWidget {
  @override
  _AllClassesScreenState createState() => _AllClassesScreenState();
}

class _AllClassesScreenState extends State<AllClassesScreen> {
  List<ClassInfo> classes = [
    ClassInfo('Nursery', 40, 25, 15),
    ClassInfo('Class 1', 50, 25, 25),
    ClassInfo('Class 2', 60, 25, 35),
  ];

  void addNewClass() {}

  void editClass(ClassInfo classInfo) {}

  void deleteClass(ClassInfo classInfo) async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Class'),
          content:
              Text('Are you sure you want to delete ${classInfo.className}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      setState(() {
        classes.remove(classInfo);
      });
      print('Deleted ${classInfo.className}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classes', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Use Navigator.pop to go back to the previous screen
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Find Class...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 1.2,
                ),
                itemCount: classes.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewClassScreen()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFf8a35a),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, size: 40.0, color: Colors.black),
                              SizedBox(height: 8.0),
                              Text('Add New',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    final classInfo = classes[index - 1];
                    return ClassCard(
                      className: classInfo.className,
                      totalStudents: classInfo.totalStudents,
                      boys: classInfo.boys,
                      girls: classInfo.girls,
                      onEdit: () => editClass(classInfo),
                      onDelete: () => deleteClass(classInfo),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddClassScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Class'),
      ),
      body: Center(
        child: Text('Add Class Screen'),
      ),
    );
  }
}

class ClassInfo {
  final String className;
  final int totalStudents;
  final int boys;
  final int girls;

  ClassInfo(this.className, this.totalStudents, this.boys, this.girls);
}

class ClassCard extends StatelessWidget {
  final String className;
  final int totalStudents;
  final int boys;
  final int girls;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  ClassCard({
    required this.className,
    required this.totalStudents,
    required this.boys,
    required this.girls,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF14DFB3),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  className,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 2, 2, 2)),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: const Color(0xFFf8a35a)),
                      iconSize: 20.0,
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      iconSize: 20.0,
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text('$totalStudents STUDENTS',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0))),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    children: [
                      Text('Boys',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 0, 0, 0))),
                      Text('$boys',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 0, 0, 0))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    children: [
                      Text('Girls',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 0, 0, 0))),
                      Text('$girls',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 0, 0, 0))),
                    ],
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
