import 'package:flutter/material.dart';
import 'package:my_first/screens/add_assignment.dart';

void main() {
  runApp(AssignmentApp());
}

class AssignmentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AssignmentScreen(),
    );
  }
}

class AssignmentScreen extends StatefulWidget {
  @override
  _AssignmentScreenState createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  String selectedClass = '';
  String selectedTeacher = '';
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Assignment', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add Assignment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF14DFB3),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0),
                minimumSize: Size(200, 50), // Fixed size
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddAssignmentScreen()),
                );
              },
            ),
            SizedBox(height: 16.0),
            _buildFilterCard(),
            SizedBox(height: 16.0),
            _buildAssignmentCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDropdownField(
                'Select Class...', ['Class-5', 'Class-6', 'Class-7'], (value) {
              setState(() => selectedClass = value!);
            }),
            SizedBox(height: 10.0),
            _buildDropdownField(
                'Select Teacher...', ['Ram Rai', 'John Doe', 'Jane Smith'],
                (value) {
              setState(() => selectedTeacher = value!);
            }),
            SizedBox(height: 10.0),
            _buildDatePicker(),
            SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.search),
              label: Text('Search'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFf8a35a),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0),
                minimumSize: Size(150, 50), // Fixed size
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(
      String hint, List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      items: items
          .map((value) => DropdownMenuItem(value: value, child: Text(value)))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDatePicker() {
    return TextFormField(
      readOnly: true,
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          setState(() => selectedDate = picked);
        }
      },
      decoration: InputDecoration(
        labelText: 'Select Date...',
        prefixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  Widget _buildAssignmentCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/2/2a/Jai_Passport_Size_Photo.jpg'),
                ),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ram Rai',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Teacher', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Spacer(),
                Text('12/12/2020',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 12.0),
            _buildInfoRow(Icons.edit, 'Class-5'),
            SizedBox(height: 8.0),
            _buildInfoRow(Icons.book, 'English'),
            SizedBox(height: 12.0),
            Divider(),
            Text('Assignment', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text(
              'Educational schoolwork assigned to be done outside the classroom.',
              style: TextStyle(fontSize: 12.0, color: Colors.black87),
            ),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildActionBtn(
                    'Edit', const Color(0xFFf8a35a), Colors.black, () {}),
                SizedBox(width: 10.0),
                _buildActionBtn('Delete', Colors.red, Colors.white, () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54),
        SizedBox(width: 8.0),
        Text(text, style: TextStyle(color: Colors.black87)),
      ],
    );
  }

  Widget _buildActionBtn(
      String label, Color bgColor, Color fgColor, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: Text(label),
    );
  }
}
