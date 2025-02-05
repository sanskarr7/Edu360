import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class AddNoticeScreen extends StatefulWidget {
  @override
  _AddNoticeScreenState createState() => _AddNoticeScreenState();
}

class _AddNoticeScreenState extends State<AddNoticeScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isTeachersSelected = false;
  bool _isParentsSelected = false;
  bool _isStudentsSelected = false;

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Function to show Date Picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate); // Format date
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Collect notice data
      Map<String, dynamic> noticeData = {
        'title': _titleController.text,
        'date': _dateController.text,
        'description': _descriptionController.text,
        'recipients': {
          'teachers': _isTeachersSelected,
          'parents': _isParentsSelected,
          'students': _isStudentsSelected,
        },
      };

      print("Notice Submitted: $noticeData");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notice Added Successfully')),
      );

      // Clear the form after submission
      _formKey.currentState!.reset();
      _titleController.clear();
      _dateController.clear();
      _descriptionController.clear();
      setState(() {
        _isTeachersSelected = false;
        _isParentsSelected = false;
        _isStudentsSelected = false;
      });
    }
  }

  // Helper method to build CheckboxListTile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Add Notice', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // Date Picker Field
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: "Date",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // Description Field
              TextFormField(
                controller: _descriptionController,
                maxLines: 8,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: "Write Notice Description...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter notice description';
                  }
                  if (value.length < 10) {
                    return 'Description must be at least 10 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // Message To (Checkboxes)
              Text(
                "MESSAGE TO",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isTeachersSelected,
                    onChanged: (value) {
                      setState(() {
                        _isTeachersSelected = value!;
                      });
                    },
                    activeColor: const Color.fromARGB(1000, 20, 191, 158),
                  ),
                  Text("Teachers"),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isParentsSelected,
                    onChanged: (value) {
                      setState(() {
                        _isParentsSelected = value!;
                      });
                    },
                    activeColor: const Color.fromARGB(1000, 20, 191, 158),
                  ),
                  Text("Parents"),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isStudentsSelected,
                    onChanged: (value) {
                      setState(() {
                        _isStudentsSelected = value!;
                      });
                    },
                    activeColor: const Color.fromARGB(1000, 20, 191, 158),
                  ),
                  Text("Students"),
                ],
              ),
              SizedBox(height: 8.0),

              // Add Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: Icon(Icons.add),
                  label: Text("Add"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 20, 223, 179),
                    foregroundColor: Colors.black,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
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
