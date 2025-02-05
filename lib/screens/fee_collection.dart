import 'package:flutter/material.dart';

class FeesCollectionScreen extends StatefulWidget {
  @override
  _FeesCollectionScreenState createState() => _FeesCollectionScreenState();
}

class _FeesCollectionScreenState extends State<FeesCollectionScreen> {
  final Map<String, TextEditingController> _controllers = {};
  double totalAmount = 20000;
  double depositAmount = 0;
  double dueBalance = 20000;

  final List<Map<String, dynamic>> feeItems = [
    {"sr": 1, "particular": "MONTHLY FEE", "amount": 18000},
    {"sr": 2, "particular": "ADMISSION FEE", "amount": 0},
    {"sr": 3, "particular": "REGISTRATION FEE", "amount": 0},
    {"sr": 4, "particular": "ART MATERIAL", "amount": 0},
    {"sr": 5, "particular": "TRANSPORT", "amount": 3000},
    {"sr": 6, "particular": "BOOKS", "amount": 500},
    {"sr": 7, "particular": "UNIFORM", "amount": 0},
    {"sr": 8, "particular": "FINE", "amount": 0},
    {"sr": 9, "particular": "OTHERS", "amount": 100},
    {"sr": 10, "particular": "PREVIOUS BALANCE", "amount": 2000},
    {"sr": 11, "particular": "DISCOUNT IN FEE 20 %", "amount": -3600},
  ];

  @override
  void initState() {
    super.initState();
    for (var item in feeItems) {
      _controllers[item["particular"]] =
          TextEditingController(text: item["amount"].toString());
    }
  }

  void _calculateTotal() {
    double sum = 0;
    for (var item in feeItems) {
      sum += double.tryParse(_controllers[item["particular"]]!.text) ?? 0;
    }
    setState(() {
      totalAmount = sum;
      dueBalance = totalAmount - depositAmount;
    });
  }

  void _updateDeposit(String value) {
    setState(() {
      depositAmount = double.tryParse(value) ?? 0;
      dueBalance = totalAmount - depositAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fees Collection',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Student Details Card
            buildStudentDetailsCard(),

            SizedBox(height: 10),

            // Fees Table
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(color: Colors.grey.shade300),
                  columnWidths: {
                    0: FixedColumnWidth(40),
                    1: FlexColumnWidth(),
                    2: FixedColumnWidth(80),
                  },
                  children: [
                    buildTableHeader(),
                    ...feeItems.map((item) => buildTableRow(item)).toList(),
                    buildTotalRow("TOTAL", totalAmount),
                    buildDepositRow(),
                    buildDueBalanceRow(),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF14DFB3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text("✓ Submit Fees",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStudentDetailsCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/profile1.png"),
              radius: 30,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Aayush Nepal",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("ID: 123456", style: TextStyle(color: Colors.grey[600])),
                  Text("Class 4", style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Due Amount",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Rs. 20000",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey.shade300),
      children: [
        tableCell("Sr.", isHeader: true),
        tableCell("Particulars", isHeader: true),
        tableCell("Amount", isHeader: true),
      ],
    );
  }

  TableRow buildTableRow(Map<String, dynamic> item) {
    return TableRow(
      children: [
        tableCell(item["sr"].toString()),
        tableCell(item["particular"]),
        tableTextFieldCell(item["particular"]),
      ],
    );
  }

  TableRow buildTotalRow(String label, double value) {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey.shade200),
      children: [
        tableCell(""),
        tableCell(label, isBold: true),
        tableCell(value.toStringAsFixed(2), isBold: true),
      ],
    );
  }

  TableRow buildDepositRow() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.white),
      children: [
        tableCell(""),
        tableCell("DEPOSIT", isBold: true),
        tableInputCell(_updateDeposit),
      ],
    );
  }

  TableRow buildDueBalanceRow() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey.shade200),
      children: [
        tableCell(""),
        tableCell("DUE-ABLE BALANCE", isBold: true),
        tableCell(dueBalance.toStringAsFixed(2), isBold: true, isRed: true),
      ],
    );
  }

  Widget tableCell(String text,
      {bool isHeader = false, bool isBold = false, bool isRed = false}) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: isHeader || isBold ? FontWeight.bold : FontWeight.normal,
          color: isRed ? Colors.red : Colors.black,
        ),
      ),
    );
  }

  Widget tableTextFieldCell(String key) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        controller: _controllers[key],
        keyboardType: TextInputType.number,
        onChanged: (_) => _calculateTotal(),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        ),
      ),
    );
  }

  Widget tableInputCell(Function(String) onChanged) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        ),
      ),
    );
  }
}
