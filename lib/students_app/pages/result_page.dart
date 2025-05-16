import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.result)),
      body: Center(child: Text(loc.result)),
    );
  }
}
