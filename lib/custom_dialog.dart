import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:logger/logger.dart';

import 'main_page.dart';
import 'package:minig/constants.dart';
import 'camera_info.dart';

var logger = Logger();

List<String> selectModel = [
  'TBX-05N',
  'NYX Series',
  'TPV-IAHDR_EO',
  'TPV-IAHDR_IR',
  'TQM-1M',
];

final TextEditingController ipFldCon = TextEditingController();
final TextEditingController portFldCon = TextEditingController();
final TextEditingController idFldCon = TextEditingController();
final TextEditingController pwFldCon = TextEditingController();

class DiaTextFld extends StatelessWidget {
  DiaTextFld(
      {super.key,
      required this.width,
      required this.height,
      required this.controller,
      required this.obscureTxt,
      required this.placeholder});

  double? width;
  double? height;
  TextEditingController? controller;
  bool obscureTxt = false;
  String? placeholder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        textAlign: TextAlign.start,
        controller: controller,
        decoration: InputDecoration(
          labelText: placeholder,
          border: OutlineInputBorder(),
        ),
        obscureText: obscureTxt,
      ),
    );
  }
} //End Of The Class

// For Camera Add Dialog
AwesomeDialog addDialog(BuildContext context) {
  String? selectedValue;

  return AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.info,
    body:
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Column(
        children: [
          Text(
            'Input a Device Information',
            style: TextStyle(
              fontSize: 18.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B7D76),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          DropdownButton<String>(
            value: selectedValue,
            hint: Text('Select a Model'),
            items: selectModel.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue;
              });
            },
          ),
          DiaTextFld(
              width: 200,
              height: 40,
              controller: ipFldCon,
              obscureTxt: false,
              placeholder: 'IP Address'),
          SizedBox(
            height: 10.0,
          ),
          DiaTextFld(
            width: 200,
            height: 40,
            controller: portFldCon,
            obscureTxt: false,
            placeholder: 'Port Number',
          ),
          SizedBox(
            height: 10.0,
          ),
          DiaTextFld(
            width: 200,
            height: 40,
            controller: idFldCon,
            obscureTxt: true,
            placeholder: 'ID',
          ),
          SizedBox(
            height: 10.0,
          ),
          DiaTextFld(
            width: 200,
            height: 40,
            controller: pwFldCon,
            obscureTxt: true,
            placeholder: 'PW',
          ),
        ],
      );
    }),
    title: 'Information',
    desc: 'Please Type a Information',
    btnOkOnPress: () {
      String ip = ipFldCon.text;
      int port = int.parse(portFldCon.text);
      String id = idFldCon.text;
      String pw = pwFldCon.text;

      if (selectedValue!.isNotEmpty) {
        kcameraInfo.add(CameraInfo(
            model: selectedValue!, ip: ip, port: port, id: id, pw: pw));
        mainPageKey.currentState?.addListTile(kcameraInfo.last.model);

        logger.i(kcameraList);
        resetTextFld();
      }
    },
    btnCancelOnPress: () {
      logger.i('Cancel Btn Was Pressed');
      resetTextFld();
    },
    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: false,
    onDismissCallback: (type) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Dismissed by $type'),
        ),
      );
    },
  );
}

// 2024.12.23: Reset Dialog Textfield
void resetTextFld() {
  ipFldCon.text = '';
  portFldCon.text = '';
  idFldCon.text = '';
  pwFldCon.text = '';
}
