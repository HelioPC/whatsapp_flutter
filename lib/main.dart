import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Whatsapp'),
          backgroundColor: const Color.fromRGBO(7, 94, 84, 1),
        ),
        body: const Center(
          child: Text('Whatsapp flutter clone'),
        ),
      ),
    );
  }
}
