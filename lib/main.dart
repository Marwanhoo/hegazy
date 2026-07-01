import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/home/views/home_screen.dart';

void main() {
  runApp(const HegazyApp());
}

class HegazyApp extends StatelessWidget {
  const HegazyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hegazy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeScreen(),
    );
  }
}
