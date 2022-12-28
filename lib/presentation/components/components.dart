import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

import '../screens/login_screen.dart';

const primaryColor = Colors.pinkAccent;
const titleTextStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
const subTitleTextStyle = TextStyle(fontSize: 20);

showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    gravity: ToastGravity.CENTER,
  );
}

signOut(context) async {
  Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
 // await Hive.box('data').delete(HiveKeys.token);
}