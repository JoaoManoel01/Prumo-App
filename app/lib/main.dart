import 'package:flutter/material.dart';

import 'presentation/screens/home_shell.dart';
import 'presentation/theme/app_theme.dart';

void main() {
  runApp(const PrumoApp());
}

class PrumoApp extends StatelessWidget {
  const PrumoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prumo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeShell(),
    );
  }
}
