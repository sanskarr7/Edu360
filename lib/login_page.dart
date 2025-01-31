import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const LoginPage({super.key, required this.onLocaleChange});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  static const String superAdminEmail = "superadmin@example.com";
  static const String superAdminPassword = "SuperAdmin@123";

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (_emailController.text.trim() == superAdminEmail &&
          _passwordController.text.trim() == superAdminPassword) {
        Navigator.pushReplacementNamed(context, '/adminDashboard');
        return;
      }

      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (response.user != null) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 100),
            _buildLanguageDropdown(),
            _buildWelcomeSection(localizations),
            const SizedBox(height: 48),
            _buildLoginForm(localizations),
            const SizedBox(height: 32),
            _buildSignInButton(localizations),
            const SizedBox(height: 24),
            _buildForgotPassword(localizations),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return DropdownButton<Locale>(
      value: Localizations.localeOf(context),
      onChanged: (Locale? newLocale) {
        if (newLocale != null) widget.onLocaleChange(newLocale);
      },
      items: const [
        DropdownMenuItem(value: Locale('en'), child: Text('English')),
        DropdownMenuItem(value: Locale('ne'), child: Text('नेपाली')),
      ],
    );
  }

  Widget _buildWelcomeSection(AppLocalizations localizations) {
    return Column(
      children: [
        Text(localizations.welcome,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
        Text(localizations.back,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Text(localizations.continueJourney,
            style: TextStyle(fontSize: 16, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildLoginForm(AppLocalizations localizations) {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: localizations.email,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: localizations.password,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton(AppLocalizations localizations) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _signIn,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF73BDB6),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(
            color: Color.fromARGB(255, 14, 13, 13))
            : Text(
          localizations.signIn,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 32, 32, 32),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword(AppLocalizations localizations) {
    return TextButton(
      onPressed: () async {
        if (_emailController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(localizations.enterEmailToReset),
                backgroundColor: Colors.red),
          );
          return;
        }

        try {
          await Supabase.instance.client.auth
              .resetPasswordForEmail(_emailController.text.trim());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(localizations.passwordResetEmailSent),
                backgroundColor: Colors.green),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("${localizations.error}: ${e.toString()}"),
                backgroundColor: Colors.red),
          );
        }
      },
      child: Text(localizations.forgotPassword,
          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
    );
  }
}
