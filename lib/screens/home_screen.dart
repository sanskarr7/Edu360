import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stat Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard(
                    'Total Students', '500', Icons.people, Color(0xFF60B8AF)),
                _buildStatCard(
                    'Total Teachers', '8', Icons.work, const Color(0xFFf8a35a)),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard('Revenue', 'Rs.20000', Icons.attach_money,
                    const Color.fromARGB(255, 76, 175, 80)),
                _buildStatCard('Total Profit', 'Rs.20000', Icons.trending_up,
                    const Color.fromARGB(255, 1, 8, 7)),
              ],
            ),
            SizedBox(height: 16.0),

            // Circular Chart
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Estimated Fee This Month',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(height: 16.0),
                    SizedBox(
                      height: 150,
                      child: SfCircularChart(
                        // title: ChartTitle(text: ''),
                        legend: Legend(isVisible: true),
                        series: <CircularSeries>[
                          PieSeries<ChartData, String>(
                            dataSource: [
                              ChartData(
                                  'Collections', 4000, const Color(0xFF4CAF50)),
                              ChartData('Remainings', 29000, Colors.red),
                            ],
                            xValueMapper: (ChartData data, _) => data.label,
                            yValueMapper: (ChartData data, _) => data.value,
                            pointColorMapper: (ChartData data, _) => data.color,
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              labelPosition: ChartDataLabelPosition.outside,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCollectionInfo(
                            'Collections', 'Rs.4000', const Color(0xFF4CAF50)),
                        _buildCollectionInfo(
                            'Remainings', 'Rs.29,000', Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Progress Indicators
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildProgressRow(
                        'Today Present Students', 0.7, Colors.blue),
                    _buildProgressRow(
                        'Today Present Teachers', 0.9, Colors.green),
                    _buildProgressRow(
                        'This Month Fee Collection', 0.24, Colors.purple),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Calendar
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: DateTime.now(),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: const Color.fromARGB(255, 58, 190, 173),
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.white, size: 30.0),
              SizedBox(height: 8.0),
              Text(title,
                  style: TextStyle(color: Colors.white, fontSize: 14.0)),
              SizedBox(height: 8.0),
              Text(value,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCollectionInfo(String title, String value, Color color) {
    return Column(
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 14.0, color: color, fontWeight: FontWeight.bold)),
        SizedBox(height: 4.0),
        Text(value,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildProgressRow(String title, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.grey.shade300,
          color: color,
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}

class ChartData {
  final String label;
  final double value;
  final Color color;

  ChartData(this.label, this.value, this.color);
}
