import 'package:flutter/material.dart';
import 'package:task_1/ui/file_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter XLSX Upload',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FileScreen(),
    );
  }
}
