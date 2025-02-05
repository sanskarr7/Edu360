import 'package:flutter/material.dart';
import 'fee_collection.dart'; // Import the fee_collection.dart file

class CollectFeesScreen extends StatefulWidget {
  @override
  _CollectFeesScreenState createState() => _CollectFeesScreenState();
}

class _CollectFeesScreenState extends State<CollectFeesScreen> {
  String? selectedClass;
  final TextEditingController searchController = TextEditingController();

  final List<String> classOptions = ["All", "Class 1", "Class 2"];

  // Sample Data
  final Map<String, List<Map<String, dynamic>>> studentsByGroup = {
    "A": [
      {
        "name": "Aayush Nepal",
        "id": "123456",
        "amount": "20000",
        "image": "assets/profile1.png"
      },
      {
        "name": "Aayush Rai",
        "id": "123453",
        "amount": "30000",
        "image": "assets/profile1.png"
      },
    ],
    "B": [
      {
        "name": "Bishal Tamang",
        "id": "12325",
        "amount": "40000",
        "image": "assets/profile1.png"
      },
      {
        "name": "Binish Rai",
        "id": "123456",
        "amount": "20045",
        "image": "assets/profile1.png"
      },
    ],
    "D": [
      {
        "name": "Dipak Gole",
        "id": "123457",
        "amount": "20000",
        "image": "assets/profile1.png"
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Collect Fees', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown & Search Bar
            Row(
              children: [
                buildDropdown("Class", selectedClass, classOptions, (value) {
                  setState(() {
                    selectedClass = value;
                  });
                }),
                SizedBox(width: 10),
                Expanded(
                  child: buildSearchBar(),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Student List
            Expanded(
              child: ListView(
                children: studentsByGroup.entries.map((entry) {
                  return buildStudentGroup(entry.key, entry.value);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dropdown Widget
  Widget buildDropdown(String hint, String? value, List<String> items,
      Function(String?) onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 20, 223, 179),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton<String>(
        dropdownColor: const Color.fromARGB(255, 20, 223, 179),
        value: value,
        isExpanded: false,
        underline: SizedBox(),
        hint: Text(hint),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  // Search Bar Widget
  Widget buildSearchBar() {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Search Student",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  // Student Group Section
  Widget buildStudentGroup(
      String groupName, List<Map<String, dynamic>> students) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(groupName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        ...students.map((student) => buildStudentCard(student)).toList(),
        SizedBox(height: 10),
      ],
    );
  }

  // Student Card Widget
  Widget buildStudentCard(Map<String, dynamic> student) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FeesCollectionScreen(),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              // Profile Image
              CircleAvatar(
                backgroundImage: AssetImage(student["image"]),
                radius: 30,
              ),
              SizedBox(width: 10),

              // Student Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(student["name"],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("ID: ${student["id"]}",
                        style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),

              // Due Amount
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Due Amount",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Rs. ${student["amount"]}",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
