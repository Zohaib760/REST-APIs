



import 'package:flutter/material.dart';
import 'package:rest_api/Models/example_three.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExampleThree(),
    );
  }
}

