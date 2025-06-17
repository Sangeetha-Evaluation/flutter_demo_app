import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_model/news_view_model.dart';
import 'screens/view/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NewsViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space News',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: const HomeScreen(),
    );
  }
}
