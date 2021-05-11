import 'package:coronavirus/main/mainpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CoronaApp());
}

class CoronaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
