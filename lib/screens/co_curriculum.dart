import 'package:flutter/material.dart';
import 'package:my_first/screens/add_notice.dart';

class CoCurriculum extends StatefulWidget {
  @override
  _NoticeBoardScreenState createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<CoCurriculum> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> notices = [
    {
      "title": "Bio Lab",
      "content": "This is the content of notice 1",
      "expanded": false
    },
    {
      "title": "Computer Lab",
      "content":
          "Due to unexpected circumstances, academic activities are postponed.",
      "expanded": false
    },
    {
      "title": "Social fieldtrip",
      "content":
          "All students must strictly adhere to the timetable and school rules.",
      "expanded": false
    },
    {
      "title": "Nepali Poem presentation",
      "content": "The school will remain closed on Sunday.",
      "expanded": false
    }
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterNotices);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterNotices() {
    setState(() {}); // Rebuild UI to reflect search filter
  }

  List<Map<String, dynamic>> get filteredNotices {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) return notices;
    return notices
        .where((notice) => notice["title"].toLowerCase().contains(query))
        .toList();
  }

  void _toggleExpand(int index) {
    setState(() {
      notices[index]["expanded"] = !notices[index]["expanded"];
    });
  }

  void _navigateToAddNotice() async {
    final newNotice = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNoticeScreen()),
    );

    if (newNotice != null) {
      setState(() {
        notices.add(newNotice);
      });
    }
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Delete"),
        content: Text("Are you sure you want to delete this notice?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                notices.removeAt(index);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }

  void _editNotice(int index) {
    // Implement your edit functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Co-Crriculum', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Find Notices...",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
            SizedBox(height: 10),

            // Add Notice Button
            ElevatedButton.icon(
              onPressed: _navigateToAddNotice, // Navigate to Add Notice screen
              icon: Icon(Icons.add),
              label: Text("Add Notice"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(251, 192, 45, 1),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
            SizedBox(height: 10),

            // Notices List
            Expanded(
              child: ListView.builder(
                itemCount: filteredNotices.length,
                itemBuilder: (context, index) {
                  final notice = filteredNotices[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: ExpansionTile(
                      title: Text(notice["title"]),
                      trailing: Icon(
                        notice["expanded"]
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.black54,
                      ),
                      onExpansionChanged: (expanded) {
                        _toggleExpand(notices.indexOf(notice));
                      },
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text(notice["content"],
                              style: TextStyle(color: Colors.black87)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit,
                                  color: const Color.fromRGBO(251, 192, 45, 1)),
                              onPressed: () =>
                                  _editNotice(notices.indexOf(notice)),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  _confirmDelete(notices.indexOf(notice)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
