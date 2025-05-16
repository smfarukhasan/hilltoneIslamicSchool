import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../global_functions/snack_bar.dart';
import '../l10n/app_localizations.dart';
import '../students_app/student_home.dart';
import '../teachers_app/teacher_home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  bool _showFooter = true;

  final Map<String, Map<String, String>> users = {
    's': {'pin': '1234', 'role': 'student'},
    't': {'pin': '123', 'role': 'teacher'},
  };

  void _login() {
    String id = _idController.text.trim();
    String pin = _pinController.text.trim();

    if (users.containsKey(id) && users[id]!['pin'] == pin) {
      String role = users[id]!['role']!;
      if (role == 'student') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const StudentHome()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TeacherHome()),
        );
      }
    } else {
      showGlobalSnackBar(context, 'Invalid ID or PIN');
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: SingleChildScrollView(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 400,
                      minHeight: constraints.maxHeight * 0.90,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),

                        // Logo
                        Image.asset(
                          'assets/logo.png',
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 5),

                        // Login Card
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  loc.loginTitle,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                const SizedBox(height: 30),

                                // ID Field
                                TextField(
                                  controller: _idController,
                                  onTap: () {
                                    setState(() => _showFooter = false);
                                  },
                                  onEditingComplete: () {
                                    setState(() => _showFooter = true);
                                    FocusScope.of(context).unfocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: loc.userId,
                                    prefixIcon: const Icon(Icons.person),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // PIN Field (numbers only)
                                TextField(
                                  controller: _pinController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  obscureText: true,
                                  onTap: () {
                                    setState(() => _showFooter = false);
                                  },
                                  onEditingComplete: () {
                                    setState(() => _showFooter = true);
                                    FocusScope.of(context).unfocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: loc.pin,
                                    prefixIcon: const Icon(Icons.lock),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),

                                // Login Button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _login,
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      backgroundColor: Colors.blueAccent,
                                    ),
                                    child: Text(
                                      loc.login,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Footer Text (hide/show based on _showFooter)
          if (_showFooter)
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Center(
                  child: Text(
                    'Developed by HE Software Solution',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
