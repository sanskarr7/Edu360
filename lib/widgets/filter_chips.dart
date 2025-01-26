import 'package:flutter/material.dart';

class FilterChips extends StatefulWidget {
  final Function(String) onFilterSelected;

  const FilterChips({Key? key, required this.onFilterSelected}) : super(key: key);

  @override
  _FilterChipsState createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  String selectedFilter = 'All Subjects';  // Default filter

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FilterChip(
            label: Text('All Subjects'),
            selected: selectedFilter == 'All Subjects',
            onSelected: (bool selected) {
              setState(() {
                selectedFilter = 'All Subjects';
              });
              widget.onFilterSelected(selectedFilter);
            },
          ),
          FilterChip(
            label: Text('Math'),
            selected: selectedFilter == 'Math',
            onSelected: (bool selected) {
              setState(() {
                selectedFilter = 'Math';
              });
              widget.onFilterSelected(selectedFilter);
            },
          ),
          FilterChip(
            label: Text('Science'),
            selected: selectedFilter == 'Science',
            onSelected: (bool selected) {
              setState(() {
                selectedFilter = 'Science';
              });
              widget.onFilterSelected(selectedFilter);
            },
          ),
        ],
      ),
    );
  }
}
