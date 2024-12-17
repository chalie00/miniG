import 'package:flutter/material.dart';
import 'Input_page.dart';

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
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21), // 색상 코드 수정
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: InputPage(), // 메인 화면 설정
    );
  }
}
