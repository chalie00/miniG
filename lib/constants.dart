import 'dart:io' show Socket;
import 'package:flutter/material.dart';
import 'camera_info.dart';

const Color kcolorTitle = Color(0xFF6B7D76);
const Color kbackGround = Color(0xFFF0F6F4);
const Color kbuttonBackG = Color(0xFF2CC98A);
const Color kbuttonTxt = Color(0xFFFFFFFF);
const Color kContent = Color(0xFF6B7D76);
const Color kContentTxt = Color(0xFF4A514f);
const Color kContentSelect = Color(0xFFF7FFFB);
const Color kContentUnSelect = Color(0xFFFFFFFF);

// only socket for mini gimbal control
late Socket ksocket;

List<CameraInfo> kcameraInfo = [];
List<String> kcameraList = [];

//selected Model
CameraInfo? kselectedCamera;
