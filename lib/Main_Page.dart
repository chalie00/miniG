import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  InputPageState createState() => InputPageState();
}

class InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Camera',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B1F16),
          ),
        ),
        backgroundColor: Color(0xFFF0F6F4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
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
                  print('pressed Add');
                },
                child: Text('Add'),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Content',
                style: TextStyle(
                  fontSize: 15,
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
                padding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 100.0),
                backgroundColor: Color(0xFF2CC98A),
              ),
              child: Text(
                'Connect',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF)),
              ),
            ),
          ),
        ],
      ),
    );
  }
} //End Of The Class
