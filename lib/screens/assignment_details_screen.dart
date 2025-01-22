import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AssignmentDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> assignment;

  AssignmentDetailsScreen({required this.assignment});

  @override
  _AssignmentDetailsScreenState createState() => _AssignmentDetailsScreenState();
}

class _AssignmentDetailsScreenState extends State<AssignmentDetailsScreen> {
  late String _fileName;
  bool _fileAttached = false;

  // Function to pick a PDF file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        _fileAttached = true;
      });
    }
  }

  // Function to submit the assignment
  void _submitAssignment() {
    // Add your logic to submit the assignment here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Assignment Submitted Successfully!')),
    );
    Navigator.pop(context);  // Navigate back after submission
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.assignment['title'],
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Assignment Title
              Text(
                widget.assignment['title'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                overflow: TextOverflow.ellipsis, // Prevent overflow
              ),
              SizedBox(height: 8),

              // Assignment Subject
              Text(
                'Subject: ${widget.assignment['subject']}',
                style: TextStyle(fontSize: 18, color: Colors.black54),
                overflow: TextOverflow.ellipsis, // Prevent overflow
              ),
              SizedBox(height: 8),

              // Due Date and Time
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Due Date: ${widget.assignment['dueDate']}',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    overflow: TextOverflow.ellipsis, // Prevent overflow
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Due Time: ${widget.assignment['dueTime']}',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    overflow: TextOverflow.ellipsis, // Prevent overflow
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Description Section
              Text(
                'Assignment Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Here you can provide additional details about the assignment, such as requirements, instructions, and grading criteria.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                softWrap: true,  // Ensure text wraps
                overflow: TextOverflow.visible, // Ensure text does not overflow
              ),
              SizedBox(height: 20),

              // Upload PDF Section
              Text(
                'Upload Homework (PDF)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: _pickFile,
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_upload,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          _fileAttached
                              ? _fileName
                              : 'Tap to select a PDF file',
                          style: TextStyle(color: Colors.black54),
                          overflow: TextOverflow.ellipsis, // Prevent overflow
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _fileAttached
                      ? _submitAssignment
                      : null,  // Only enable if file is attached
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,  // Corrected parameter
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    widget.assignment['isSubmitted']
                        ? 'Already Submitted'
                        : 'Submit Assignment',
                    style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 19, 18, 18)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
