import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class RoutinePage extends StatelessWidget {
  const RoutinePage({super.key});
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.classRoutine)),
      body: Center(child: Text(loc.classRoutine)),
    );
  }
}
