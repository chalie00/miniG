import 'package:flutter/material.dart';
import 'main_page.dart';

void main() => runApp(MiniGimbal());

class MiniGimbal extends StatefulWidget {
  const MiniGimbal({super.key});

  @override
  MiniGimbalState createState() => MiniGimbalState();
}

class MiniGimbalState extends State<MiniGimbal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFFF0F6F4),
        scaffoldBackgroundColor: Color(0xFFF0F6F4),
      ),
      home: MainPage(),
    );
  }
} //End OF The Class
