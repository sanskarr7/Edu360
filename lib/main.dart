import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login_page.dart';
import 'dashboard_page.dart';
import 'screens/home_page.dart';
import 'screens/change_profile_screen.dart';
import 'screens/leave_note_screen.dart';
import 'screens/library_screen.dart';
import 'screens/results_screen.dart';

import 'admin/admin_dashboard.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://dsgfyjzwzerewbyuunaz.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRzZ2Z5anp3emVyZXdieXV1bmF6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgyNTUzOTksImV4cCI6MjA1MzgzMTM5OX0.pXVotjHsETwzFfFyIRkZeKGXJ4igvOfxlo1IR_FE938',
  );

  // Retrieve the saved locale
  final prefs = await SharedPreferences.getInstance();
  final savedLocale = prefs.getString('locale') ?? 'en';

  runApp(MyApp(Locale(savedLocale)));
}

class MyApp extends StatefulWidget {
  final Locale initialLocale;

  const MyApp(this.initialLocale, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
  }

  void _changeLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);

    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ne'),
      ],
      locale: _locale,
      home: LoginPage(
        onLocaleChange: _changeLanguage, // Pass callback to LoginPage
      ),
      routes: {
        '/dashboard': (context) => const DashboardPage(),
        '/changeProfile': (context) => ChangeProfileScreen(),
        '/leaveNote': (context) => LeaveNoteScreen(),
        '/library': (context) => LibraryScreen(),
        '/results': (context) => ResultsScreen(),
        '/adminDashboard': (context) => const AdminDashboard(),
      },
    );
  }
}
