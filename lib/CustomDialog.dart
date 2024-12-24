import 'Main_Page.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/rendering.dart';
import 'package:minig/Constants.dart';
import 'CameraInfo.dart';

List<String> select_model = [
  'TBX-05N',
  'NYX Series',
  'TPV-IAHDR_EO',
  'TPV-IAHDR_IR',
  'TQM-1M',
];

final TextEditingController ip_fld_con = TextEditingController();
final TextEditingController port_fld_con = TextEditingController();
final TextEditingController id_fld_con = TextEditingController();
final TextEditingController pw_fld_con = TextEditingController();

class Dia_TextFld extends StatelessWidget {
  Dia_TextFld(
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
AwesomeDialog AddDialog(BuildContext context) {
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
            items: select_model.map((String item) {
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
          Dia_TextFld(
              width: 200,
              height: 40,
              controller: ip_fld_con,
              obscureTxt: false,
              placeholder: 'IP Address'),
          SizedBox(
            height: 10.0,
          ),
          Dia_TextFld(
            width: 200,
            height: 40,
            controller: port_fld_con,
            obscureTxt: false,
            placeholder: 'Port Number',
          ),
          SizedBox(
            height: 10.0,
          ),
          Dia_TextFld(
            width: 200,
            height: 40,
            controller: id_fld_con,
            obscureTxt: true,
            placeholder: 'ID',
          ),
          SizedBox(
            height: 10.0,
          ),
          Dia_TextFld(
            width: 200,
            height: 40,
            controller: pw_fld_con,
            obscureTxt: true,
            placeholder: 'PW',
          ),
        ],
      );
    }),
    title: 'Information',
    desc: 'Please Type a Information',
    btnOkOnPress: () {
      String ip = ip_fld_con.text;
      int port = int.parse(port_fld_con.text);
      String id = id_fld_con.text;
      String pw = pw_fld_con.text;

      if (selectedValue!.isNotEmpty) {
        kcameraInfo.add(CameraInfo(
            model: selectedValue!, ip: ip, port: port, id: id, pw: pw));
        mainPageKey.currentState?.addListTile(kcameraInfo.last.model);

        print(kcameraList);
        resetTextFld();
      }
    },
    btnCancelOnPress: () {
      print('Cancel Btn Was Pressed');
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
  ip_fld_con.text = '';
  port_fld_con.text = '';
  id_fld_con.text = '';
  pw_fld_con.text = '';
}
