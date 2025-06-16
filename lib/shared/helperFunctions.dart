import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast(msg){
  Fluttertoast.showToast(msg: msg, textColor: Colors.white,backgroundColor: Colors.black);
}

void NavigateTo(context,screen){
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ));
}

void NavigateAndFinish(context,screen)
{
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => screen),
        (Route<dynamic> route) => false,
  );
}
