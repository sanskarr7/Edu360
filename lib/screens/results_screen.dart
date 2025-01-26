import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  // Method to calculate total percentage for each term
  double calculateTotal(List<double> percentages) {
    double total = percentages.reduce((a, b) => a + b);
    return total / percentages.length;  // Return average percentage
  }

  @override
  Widget build(BuildContext context) {
    // Example percentages for each term
    List<double> firstTermPercentages = [67.5, 82, 57, 55, 75, 61, 45, 67];
    List<double> secondTermPercentages = [70, 80, 65, 60, 72, 65, 50, 70];
    List<double> thirdTermPercentages = [75, 85, 60, 58, 78, 72, 48, 74];
    List<double> finalPercentages = [80, 88, 70, 65, 80, 75, 55, 80];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Results",
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.orange),
      ),
      body: DefaultTabController(
        length: 4, // Number of tabs
        child: Column(
          children: [
            // TabBar for selecting different terms
            TabBar(
              indicatorColor: Colors.teal,
              tabs: [
                Tab(child: Text("1st Term", style: TextStyle(color: Colors.teal))),
                Tab(child: Text("2nd Term", style: TextStyle(color: Colors.teal))),
                Tab(child: Text("3rd Term", style: TextStyle(color: Colors.teal))),
                Tab(child: Text("Final", style: TextStyle(color: Colors.teal))),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Display 1st Term Results
                  ResultsForTerm(percentages: firstTermPercentages),
                  // Display 2nd Term Results
                  ResultsForTerm(percentages: secondTermPercentages),
                  // Display 3rd Term Results
                  ResultsForTerm(percentages: thirdTermPercentages),
                  // Display Final Term Results
                  ResultsForTerm(percentages: finalPercentages),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFF6F6F6),
    );
  }
}

class ResultsForTerm extends StatelessWidget {
  final List<double> percentages;

  ResultsForTerm({required this.percentages});

  @override
  Widget build(BuildContext context) {
    double total = calculateTotal(percentages);  // Calculate total for the term

    return Column(
      children: [
        // Display Total for the Term
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.teal[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total: ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              Text(
                "${total.toStringAsFixed(2)}%",  // Display total as percentage
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ),
        // List of Results for the Subjects in the Term
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              ResultTile(subject: "Math", percentage: percentages[0], grade: "B"),
              ResultTile(subject: "English", percentage: percentages[1], grade: "A"),
              ResultTile(subject: "Science", percentage: percentages[2], grade: "C+"),
              ResultTile(subject: "Nepali", percentage: percentages[3], grade: "C"),
              ResultTile(subject: "Computer", percentage: percentages[4], grade: "B+"),
              ResultTile(subject: "Social Study", percentage: percentages[5], grade: "B"),
              ResultTile(subject: "Health", percentage: percentages[6], grade: "C"),
              ResultTile(subject: "Economics", percentage: percentages[7], grade: "B"),
            ],
          ),
        ),
      ],
    );
  }

  double calculateTotal(List<double> percentages) {
    double total = percentages.reduce((a, b) => a + b);
    return total / percentages.length;  // Calculate and return average percentage
  }
}

class ResultTile extends StatelessWidget {
  final String subject;
  final double percentage;
  final String grade;

  ResultTile({required this.subject, required this.percentage, required this.grade});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(Icons.school, size: 40, color: Colors.teal),
        title: Text(subject, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Percentage: $percentage%"),
        trailing: Text(
          "Grade: $grade",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
        ),
      ),
    );
  }
}
