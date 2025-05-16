import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class PaymentPageT extends StatelessWidget {
  const PaymentPageT({super.key});
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.payment)),
      body: Center(child: Text(loc.payment)),
    );
  }
}
