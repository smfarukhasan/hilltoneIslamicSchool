import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class SyllabusPage extends StatelessWidget {
  const SyllabusPage({super.key});
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.syllabus)),
      body: Center(child: Text(loc.syllabus)),
    );
  }
}
