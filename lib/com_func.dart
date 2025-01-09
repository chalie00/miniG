//2025.01.03: Added Socket Communication
import 'dart:io' show Socket;
import 'package:logger/logger.dart';

import 'package:minig/constants.dart';

var logger = Logger();

Future<void> connectToMinig(String ip, int port) async {
  try {
    ksocket = await Socket.connect(ip, port);
  } catch (e) {
    logger.i('Socket error $e');
  }
}

Future<void> sendToMiniG(List<int> cmd) async {
  try {
    ksocket.add(cmd);
    ksocket.listen(
      (data) {
        // logger.i(data);
      },
      onError: (e) {
        logger.i('Communication is error $e');
      },
    );
  } catch (e) {
    logger.i('Socket error $e');
  }
}
