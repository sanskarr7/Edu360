import 'package:flutter/material.dart';

class AddStudentScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
              _buildDatePickerField(context, 'Date Of Admission'),
              SizedBox(height: 16.0),
              _buildTextField('Phone Number', 'Enter phone number'),
              SizedBox(height: 16.0),
              _buildTextField('Email', 'Enter email address'),
              SizedBox(height: 16.0),
              _buildTextField(
                  'Discount In Fee (in %)', 'Enter discount in fee'),
              SizedBox(height: 16.0),
              _buildDatePickerField(context, 'Date Of Birth'),
              SizedBox(height: 16.0),
              _buildDropdownField('Gender', ['Male', 'Female', 'Other']),
              SizedBox(height: 16.0),
              _buildTextField('Parents Name', 'Enter parents name'),
              SizedBox(height: 16.0),
              _buildTextField(
                  'Parents Phone Number', 'Enter parents phone number'),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Add picture logic
                  },
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
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Submit form logic
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

  // Helper function to build text fields
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

  // Helper function to build dropdown fields
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
      onChanged: (newValue) {
        // Handle dropdown change
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select $label';
        }
        return null;
      },
    );
  }

  // Helper function to build date picker fields
  Widget _buildDatePickerField(BuildContext context, String label) {
    return TextFormField(
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
          // Logic to handle selected date
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
