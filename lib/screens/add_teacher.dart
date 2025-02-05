import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddTeacherScreen extends StatefulWidget {
  @override
  _AddTeacherScreenState createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for date fields
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _admissionDateController =
      TextEditingController();

  File? _selectedImage; // Stores selected image

  @override
  void dispose() {
    _dobController.dispose();
    _admissionDateController.dispose();
    super.dispose();
  }

  // Function to pick an image
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  // Show dialog for choosing Camera or Gallery
  void _showImagePickerDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.blue),
              title: Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: Colors.green),
              title: Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Add Teacher', style: TextStyle(fontWeight: FontWeight.bold)),
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
              _buildTextField('Name', 'Enter full name'),
              SizedBox(height: 16.0),
              _buildTextField('Mobile NO', 'Enter mobile number'),
              SizedBox(height: 16.0),
              _buildTextField('Email Address', 'Enter email address'),
              SizedBox(height: 16.0),
              _buildDateField('Date Of Admission', _admissionDateController),
              SizedBox(height: 16.0),
              _buildDateField('Date of Birth', _dobController),
              SizedBox(height: 16.0),
              _buildDropdownField('Gender'),
              SizedBox(height: 16.0),
              _buildTextField('Home Address', 'Enter home address'),
              SizedBox(height: 16.0),
              _buildTextField('Monthly Salary', 'Enter salary'),
              SizedBox(height: 16.0),
              Center(
                child: Column(
                  children: [
                    if (_selectedImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.file(_selectedImage!,
                            width: 120, height: 120, fit: BoxFit.cover),
                      ),
                    SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () => _showImagePickerDialog(context),
                      icon: Icon(Icons.add_a_photo),
                      label: Text('Add Picture'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFf8a35a),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Teacher Added Successfully')),
                      );
                    }
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add'),
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

  Widget _buildTextField(String label, String hint) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField(String label) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      items: ['Male', 'Female', 'Other']
          .map((String value) =>
              DropdownMenuItem<String>(value: value, child: Text(value)))
          .toList(),
      onChanged: (newValue) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select $label';
        }
        return null;
      },
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        suffixIcon: Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onTap: () {
        _selectDate(context, controller);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select $label';
        }
        return null;
      },
    );
  }
}
