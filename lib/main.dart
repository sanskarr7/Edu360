// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'dashboard_page.dart';  // Import the DashboardPage
import 'screens/home_page.dart';
import 'screens/change_profile_screen.dart';
import 'screens/leave_note_screen.dart';
import 'screens/library_screen.dart';
import 'screens/results_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        onLocaleChange: _changeLanguage,
      ),
      routes: {
        '/dashboard': (context) => const DashboardPage(),
        '/changeProfile': (context) => ChangeProfileScreen(),
        '/leaveNote': (context) => LeaveNoteScreen(),
        '/library': (context) => LibraryScreen(),
        '/results': (context) => ResultsScreen(),
      },
    );
  }
}
