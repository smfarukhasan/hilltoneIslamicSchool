import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'locale_notifier.dart';
import 'l10n/app_localizations.dart';
import 'login/login_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleNotifier>(context).locale;

    return MaterialApp(
      title: 'Hilltone Islamic School',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      locale: locale,

      supportedLocales: const [
        Locale('en'),
        Locale('bn'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const LoginPage(),
    );
  }
}