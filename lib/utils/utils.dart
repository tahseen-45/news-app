import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/res/colors.dart';
class Utils{
  static flutterToast(String message){
  Fluttertoast.showToast(msg: message,
  toastLength: Toast.LENGTH_LONG
  );
  }
  static flushBar(String message,BuildContext context){
    showFlushbar(context: context,
        flushbar: Flushbar(message: message,
        borderRadius: BorderRadius.circular(15),
          backgroundColor: AppColor.blue,
          duration: Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.TOP,
          maxWidth: MediaQuery.of(context).size.width*0.9,
        )..show(context)
    );
  }





  static void focusChanger(BuildContext context,FocusNode firstNode,FocusNode secondNode){
    firstNode.unfocus();
    FocusScope.of(context).requestFocus(secondNode);
  }

  static snackBar(String message,BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message),
        duration: Duration(seconds: 10),
          showCloseIcon: true,
          dismissDirection: DismissDirection.endToStart,
        )
    );
  }

}