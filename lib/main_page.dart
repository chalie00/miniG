import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter/services.dart';

import 'package:minig/constants.dart';
import 'custom_dialog.dart';
import 'com_func.dart';
import 'control_page.dart';

var logger = Logger();

// 2024.12.24: Added Global Key for Listview Tile update
final GlobalKey<MainPageState> mainPageKey = GlobalKey<MainPageState>();

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: mainPageKey);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  //2025.01.08 Added Portrait Mode
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  // 2024.12.24: ListView Tile Update
  void addListTile(String newItem) {
    setState(() {
      kcameraList.add(newItem);
    });
  }

  // Index selected tile of Listview
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Camera',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: kcolorTitle,
          ),
        ),
        backgroundColor: kbackGround,
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
              child: SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    // 2024.12.19: Add AwesomeDialog for Camera Add
                    addDialog(context).show();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kbuttonBackG,
                    minimumSize: Size(110, 35),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: kbuttonTxt,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.add_a_photo_outlined,
                        size: 22,
                      ),
                    ],
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
                  color: kContent,
                ),
              ),
            ),
            Expanded(
              // 2024.12.24: Added number, camera title, icon of Content
              child: ListView.builder(
                itemCount: kcameraList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(kcameraList[index]),
                    // Swipe Right -> Left is only operate
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.green,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      //Swipe Left -> Right is not operate
                      if (direction == DismissDirection.startToEnd) {
                        // Left -> Right Swipe
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Edited ${kcameraList[index]}")),
                        );
                        return;
                      } else if (direction == DismissDirection.endToStart) {
                        // Right -> Left Swipe
                        setState(() {
                          kcameraList.removeAt(index);
                          kcameraInfo.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Deleted ${kcameraList[index]}")),
                        );
                      }
                    },
                    child: ListTile(
                      leading: Text('${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kContentTxt,
                          )),
                      title: Text(
                        kcameraList[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kContentTxt,
                        ),
                      ),
                      tileColor: selectedIndex == index
                          ? kContentSelect
                          : kContentUnSelect,
                      subtitle: Text(
                          '${kcameraInfo[index].ip}:${kcameraInfo[index].port}'),
                      trailing: IconButton(
                          onPressed: () {
                            logger.i('Icon was Pressed');
                          },
                          icon: Icon(Icons.create)),
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          kselectedCamera = kcameraInfo[index];
                          print(kselectedCamera);
                        });
                        logger.i('Item ${kcameraInfo[index].model} was tapped');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            // 2024.01.06 Move to Control Page when pressed connect button
            child: ElevatedButton(
              onPressed: () {
                logger.i('Connect');
                if (selectedIndex != null) {
                  String model = kcameraInfo[selectedIndex!].model;
                  String ip = kcameraInfo[selectedIndex!].ip;
                  int port = kcameraInfo[selectedIndex!].port;
                  connectToMinig(ip, port);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          //rtsp://root:root@192.168.100.153:554/cam0_0
                          ControlPage(
                              index: selectedIndex!,
                              rtspUrl:
                                  'rtsp://root:root1@192.168.100.153:554/cam0_0'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 90.0),
                backgroundColor: kbuttonBackG,
              ),
              child: Text(
                'Connect',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kbuttonTxt,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} //End Of The Class
