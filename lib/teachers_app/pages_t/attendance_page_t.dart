import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class AttendancePageT extends StatelessWidget {
  const AttendancePageT({super.key});
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.attendance)),
      body: Center(child: Text(loc.attendance)),
    );
  }
}
