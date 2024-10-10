import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';
import 'package:task_2/ui/form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizingBuilder(builder: () {
      return MaterialApp(
        title: '',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: ''),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TransactionForm(),
    );
  }
}
