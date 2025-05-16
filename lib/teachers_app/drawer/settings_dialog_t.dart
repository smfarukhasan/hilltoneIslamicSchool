import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../locale_notifier.dart';
import '../../l10n/app_localizations.dart';
import '../../login/change_pin_dialog.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    final locale = Provider.of<LocaleNotifier>(context, listen: false).locale;
    _selectedLanguage = locale.languageCode;
  }

  void _changePin() {
    showDialog(
      context: context,
      builder: (_) => const ChangePinDialog(),
    );
  }

  void _applyLanguageChange() {
    Provider.of<LocaleNotifier>(context, listen: false).setLocale(_selectedLanguage);
    Navigator.pop(context);
  }

  Widget _buildLanguageOption(String langCode, String title) {
    final isSelected = _selectedLanguage == langCode;
    return InkWell(
      onTap: () => setState(() => _selectedLanguage = langCode),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.teal.shade50,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.teal.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked_outlined : Icons.radio_button_off,
              color: isSelected ? Colors.blue : Colors.teal,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight:
                isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.blue.shade700 : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return AlertDialog(
      title: const Text(
        'Settings',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                loc.changeLanguage,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildLanguageOption('en', 'English'),
            _buildLanguageOption('bn', 'বাংলা'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // ✅ পুরো available প্রস্থ নিবে
              child: ElevatedButton.icon(
                onPressed: _changePin,
                icon: const Icon(Icons.lock, color: Colors.white),
                label: Text(
                  loc.changePin,
                  style: const TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(loc.cancel),
        ),
        ElevatedButton(
          onPressed: _applyLanguageChange,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.teal,
          ),
          child: Text(
            loc.save,
            style: const TextStyle(color: Colors.white),
          ),
        ),

      ],
    );
  }
}
