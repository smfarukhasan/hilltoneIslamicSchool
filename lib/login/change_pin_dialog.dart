import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class ChangePinDialog extends StatefulWidget {
  const ChangePinDialog({super.key});

  @override
  State<ChangePinDialog> createState() => _ChangePinDialogState();
}

class _ChangePinDialogState extends State<ChangePinDialog> {
  final _oldPinController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  void _savePin() {
    // final oldPin = _oldPinController.text.trim();
    final newPin = _newPinController.text.trim();
    final confirmPin = _confirmPinController.text.trim();

    if (newPin != confirmPin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('নতুন পিন মিলছে না')),
      );
      return;
    }

    // এখানে পিন পরিবর্তনের লজিক বসাতে পারেন
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('পিন সফলভাবে পরিবর্তন হয়েছে')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Center(
        child: Text(
          loc.changePin,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _oldPinController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'পুরাতন পিন লিখুন',
                hintText: 'Enter Old PIN',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _newPinController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'নতুন পিন লিখুন',
                hintText: 'Enter new PIN',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _confirmPinController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'আবার নতুন পিন লিখুন',
                hintText: 'Re-enter new PIN',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: _savePin,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          child: Text(loc.save),
        ),
      ],
    );
  }
}
