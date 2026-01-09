import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dailybrain/core/theme/app_theme.dart';
import 'package:dailybrain/l10n/generated/app_localizations.dart';

/// Main application widget
/// Constitution Principle VII: Internationalization-First Design
/// Constitution Principle I: Mobile-First Performance
class DailyBrainApp extends StatelessWidget {
  const DailyBrainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App metadata
      title: 'DailyBrain',
      debugShowCheckedModeBanner: false,

      // Constitution Principle VII: Internationalization
      // Support for English and French (MVP requirement)
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('fr', ''), // French
      ],

      // Theme using design system
      theme: AppTheme.lightTheme,

      // Home screen (will be implemented in next iteration)
      home: const Scaffold(
        body: Center(
          child: Text('DailyBrain - Setup Complete'),
        ),
      ),
    );
  }
}
