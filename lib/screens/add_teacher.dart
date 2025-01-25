import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    _dobController.dispose();
    _admissionDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), // Earliest date
      lastDate: DateTime.now(), // Latest date
    );

    if (pickedDate != null) {
      setState(() {
        controller.text =
            "${pickedDate.toLocal()}".split(' ')[0]; // Format date
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
              // Name Field
              _buildTextField('Name', 'Enter full name'),
              SizedBox(height: 16.0),

              // Mobile Number Field
              _buildTextField('Mobile NO', 'Enter mobile number'),
              SizedBox(height: 16.0),

              // Email Field
              _buildTextField('Email Address', 'Enter email address'),
              SizedBox(height: 16.0),

              // Date of Admission Field
              _buildDateField('Date Of Admission', _admissionDateController),
              SizedBox(height: 16.0),

              // Date of Birth Field
              _buildDateField('Date of Birth', _dobController),
              SizedBox(height: 16.0),

              // Gender Dropdown
              _buildDropdownField('Gender'),
              SizedBox(height: 16.0),

              // Home Address Field
              _buildTextField('Home Address', 'Enter home address'),
              SizedBox(height: 16.0),

              // Monthly Salary Field
              _buildTextField('Monthly Salary', 'Enter salary'),
              SizedBox(height: 16.0),

              // Add Picture Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Logic to add picture
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

              // Add Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Logic to submit form
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Teacher Added Successfully')),
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
      onChanged: (newValue) {
        // Logic to handle dropdown change
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select $label';
        }
        return null;
      },
    );
  }

  // Helper function to build date fields
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
