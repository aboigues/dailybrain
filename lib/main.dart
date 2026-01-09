import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dailybrain/app.dart';

/// Main entry point for DailyBrain
/// Constitution Principle VII: Internationalization-First Design
/// Constitution Principle IV: Feature-Based Architecture
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  // Constitution Technical Standards: Firebase as primary backend
  await Firebase.initializeApp();

  // Run app with Riverpod for state management
  // Constitution Technical Standards: Riverpod 2.4+
  runApp(
    const ProviderScope(
      child: DailyBrainApp(),
    ),
  );
}
