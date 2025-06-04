import 'dart:async';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'login_page.dart';

void showLogoutSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) => const LogoutSheetContent(),
  );
}

class LogoutSheetContent extends StatefulWidget {
  const LogoutSheetContent({super.key});

  @override
  State<LogoutSheetContent> createState() => _LogoutSheetContentState();
}

class _LogoutSheetContentState extends State<LogoutSheetContent> {
  double _progress = 0.0;
  Timer? _timer;

  void _startHoldToLogout(BuildContext context) {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += 0.05;
        if (_progress >= 1.0) {
          _timer?.cancel();
          _logout(context);
        }
      });
    });
  }

  void _cancelHold() {
    _timer?.cancel();
    setState(() {
      _progress = 0.0;
    });
  }

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6, // ৬০% স্ক্রিন
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                AppLocalizations.of(context)!.holdToLogout,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            GestureDetector(
              onLongPressStart: (_) => _startHoldToLogout(context),
              onLongPressEnd: (_) => _cancelHold(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: CircularProgressIndicator(
                      value: _progress,
                      strokeWidth: 6,
                      backgroundColor: Colors.grey[300],
                      color: Colors.redAccent,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                    ),
                    padding: const EdgeInsets.all(20),
                    child: const Icon(
                      Icons.power_settings_new,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.cancel_outlined),
              label: Text(
                AppLocalizations.of(context)!.cancel,
                style: const TextStyle(fontSize: 16),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
