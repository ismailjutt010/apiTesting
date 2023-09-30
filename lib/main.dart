import 'package:api/home_screen.dart';
import 'package:flutter/material.dart';

import 'example_four.dart';
import 'example_three.dart';
import 'example_two.dart';
import 'ismail_test.dart';

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
      // home: const HomeScreen(),
      // home: const ExampleTwo(),
      // home: ExampleThree(),
      //  home: ExampleFour(),
      home: IsmailTest(),
    );
  }
}
