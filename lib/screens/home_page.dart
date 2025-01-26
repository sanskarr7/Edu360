import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/grid_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    // Define menu items for the grid
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.person,
        'label': localizations.notice,
        'route': '/notice',
      },
      {
        'icon': Icons.calendar_today,
        'label': localizations.calendar,
        'route': '/calendar',
      },
      {
        'icon': Icons.settings,
        'label': localizations.settings,
        'route': '/settings',
      },
      {
        'icon': Icons.school,
        'label': localizations.attendance,
        'route': '/attendance',
      },
      {
        'icon': Icons.library_books,
        'label': localizations.library,
        'route': '/library',
      },
      {
        'icon': Icons.assignment,
        'label': localizations.assignment,
        'route': '/assignment',
      },
      {
        'icon': Icons.subject,
        'label': localizations.subjects,
        'route': '/subjects',
      },
      {
        'icon': Icons.grade,
        'label': localizations.result,
        'route': '/results',
      },
      {
        'icon': Icons.bus_alert,
        'label': localizations.bus,
        'route': '/bus',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: menuItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            final item = menuItems[index];
            return GridItem(
              icon: item['icon'],
              label: item['label'],
              onTap: () {
                Navigator.pushNamed(context, item['route']);
              },
            );
          },
        ),
      ),
    );
  }
}
