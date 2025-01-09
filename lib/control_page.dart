//2025.01.06: Added Control Page for VLC, PTZ
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import 'main_page.dart';
import 'package:minig/com_func.dart';
import 'package:minig/constants.dart';

class ControlPage extends StatefulWidget {
  final int index;
  final String rtspUrl;

  const ControlPage({super.key, required this.index, required this.rtspUrl});

  @override
  _ControlPageState createState() => _ControlPageState();
}

// 2025.01.09 applied VLC Library
class _ControlPageState extends State<ControlPage> {
  late VlcPlayerController _vlcPlayerController;
  bool _showControls = false;

  @override
  void initState() {
    super.initState();
    _vlcPlayerController = VlcPlayerController.network(widget.rtspUrl,
        hwAcc: HwAcc.full, autoPlay: true);
    // 2025.01.08 Display rotated to landscape mode when back button was pressed
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose() {
    _vlcPlayerController.stop();
    _vlcPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30.0,
        title: Text(kselectedCamera != null
            ? kselectedCamera!.model
            : 'No Camera Selected'),
        // 2025.01.08 Display rotated to portrait mode when back button was pressed
        leading: IconButton(
            onPressed: () {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
              ]);
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Stack(
        children: [
          // VLC Player
          Positioned.fill(
            child: VlcPlayer(
              controller: _vlcPlayerController,
              aspectRatio: 16 / 9,
              virtualDisplay: true,
            ),
          ),

          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showControls = !_showControls;
                  print("VLC tapped, showControls: $_showControls");
                });
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),

          if (_showControls)
            Positioned(
              bottom: 50,
              left: 200,
              right: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    _showControls = false;
                    print("Joystick layer tapped, hiding controls");
                  });
                },
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.transparent,
                  child: Center(
                    child: Row(
                      children: [
                        // Joystick
                        SizedBox(
                          width: 100,
                          height: 100,
                          // 2025.01.09 applied Joystick Library
                          child: Joystick(
                            mode: JoystickMode.all,
                            listener: (coordinate) {
                              if (coordinate.y > 0.8) {
                                print('down');
                                ptzCmd('down');
                              } else if (coordinate.y < -0.8) {
                                print('up');
                                ptzCmd('up');
                              } else if (coordinate.x > 0.8) {
                                print('right');
                                ptzCmd('right');
                              } else if (coordinate.x < -0.8) {
                                print('left');
                                ptzCmd('left');
                              } else if (coordinate.y < -0.5 &&
                                  coordinate.x < -0.5) {
                                print('upleft');
                                ptzCmd('upleft');
                              } else if (coordinate.y < -0.5 &&
                                  coordinate.x > 0.5) {
                                print('upright');
                                ptzCmd('upright');
                              } else if (coordinate.y > 0.5 &&
                                  coordinate.x < -0.5) {
                                print('downleft');
                                ptzCmd('downleft');
                              } else if (coordinate.y > 0.5 &&
                                  coordinate.x > 0.5) {
                                print('downright');
                                ptzCmd('downright');
                              }
                              if (coordinate.x == 0 && coordinate.y == 0) {
                                print('Stop');
                                ptzCmd('stop');
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 300),
                        ElevatedButton(
                          onPressed: () {
                            print('back was pressed');
                          },
                          child: const Text('Focus'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void ptzCmd(String direct) {
    var ptz_cmd = {
      'up': [0xFF, 0x00, 0x00, 0x08, 0x00, 0xFF, 0x07],
      'down': [0xFF, 0x00, 0x00, 0x10, 0x00, 0xFF, 0x0F],
      'left': [0xFF, 0x00, 0x00, 0x04, 0xFF, 0x00, 0x03],
      'right': [0xFF, 0x00, 0x00, 0x02, 0xFF, 0x00, 0x01],
      'upleft': [0xFF, 0x00, 0x00, 0x0C, 0x7F, 0x3F, 0xCA],
      'upright': [0xFF, 0x00, 0x00, 0x0A, 0x7F, 0x3F, 0xC8],
      'downleft': [0xFF, 0x00, 0x00, 0x14, 0x7F, 0x3F, 0xD2],
      'downright': [0xFF, 0x00, 0x00, 0x12, 0x7F, 0x3F, 0xD0],
      'stop': [0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
    };
    print(ptz_cmd[direct]);
    sendToMiniG(ptz_cmd[direct]!);
  }
}

//TODO: how to know position of user was touched
//TODO: how to know screen size(pixel) of the device working on
//TODO: how to get a value when navigator is dismissing
