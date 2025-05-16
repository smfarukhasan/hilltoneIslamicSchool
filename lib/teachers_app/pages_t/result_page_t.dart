import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class ResultPageT extends StatelessWidget {
  const ResultPageT({super.key});
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.result)),
      body: Center(child: Text(loc.result)),
    );
  }
}
