import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateOfAdmissionController =
      TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  File? _selectedImage; // Stores selected image

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Add Student', style: TextStyle(fontWeight: FontWeight.bold)),
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
              _buildTextField('Registration No', 'Enter registration number'),
              SizedBox(height: 16.0),
              _buildDropdownField(
                  'Select Class', ['Class 1', 'Class 2', 'Class 3']),
              SizedBox(height: 16.0),
              _buildDatePickerField(
                  context, 'Date Of Admission', _dateOfAdmissionController),
              SizedBox(height: 16.0),
              _buildTextField('Phone Number', 'Enter phone number'),
              SizedBox(height: 16.0),
              _buildTextField('Email', 'Enter email address'),
              SizedBox(height: 16.0),
              _buildTextField(
                  'Discount In Fee (in %)', 'Enter discount in fee'),
              SizedBox(height: 16.0),
              _buildDatePickerField(
                  context, 'Date Of Birth', _dateOfBirthController),
              SizedBox(height: 16.0),
              _buildDropdownField('Gender', ['Male', 'Female', 'Other']),
              SizedBox(height: 16.0),
              _buildTextField('Parents Name', 'Enter parents name'),
              SizedBox(height: 16.0),
              _buildTextField(
                  'Parents Phone Number', 'Enter parents phone number'),
              SizedBox(height: 16.0),
              Center(
                child: Column(
                  children: [
                    if (_selectedImage != null) // Show selected image preview
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
                        backgroundColor: Colors.yellow.shade700,
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
                        SnackBar(content: Text('Student Added Successfully')),
                      );
                    }
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade700,
                    foregroundColor: Colors.black,
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
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

  Widget _buildDropdownField(String label, List<String> items) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      items: items
          .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
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

  Widget _buildDatePickerField(
      BuildContext context, String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState(() {
            controller.text = formattedDate;
          });
        }
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
