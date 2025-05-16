import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class SyllabusPageT extends StatelessWidget {
  const SyllabusPageT({super.key});
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.syllabus)),
      body: Center(child: Text(loc.syllabus)),
    );
  }
}
