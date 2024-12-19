import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'CustomDialog.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Camera',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6B7D76),
          ),
        ),
        backgroundColor: Color(0xFFF0F6F4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'Images/TBT.png',
                width: 150.0,
                height: 75.0,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () {
                  //TODO: 2024.12.19: Add AwesomeDialog for Camera Add
                  AddDialog(context).show();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2CC98A),
                ),
                child: Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Content',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B7D76),
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text('List 1'),
                ),
                ListTile(
                  title: Text('List 2'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: ElevatedButton(
              onPressed: () {
                print('Connect');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 90.0),
                backgroundColor: Color(0xFF2CC98A),
              ),
              child: Text(
                'Connect',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} //End Of The Class
