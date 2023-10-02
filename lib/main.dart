import 'package:flutter/material.dart';
import 'PostApis/sugnup.dart';
import 'PostApis/upload_image.dart';

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
      //  home: IsmailTest(),
      //  home: SighUpScreen(),
      home: UploadImage(),
    );
  }
}
