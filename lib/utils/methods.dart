import 'package:expense_management/models/category.dart';
import 'package:expense_management/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';

Route slideLeft(Widget next) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => next,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Widget loadingPage() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Future<bool> checkConnection() async{
  var result = await (Connectivity().checkConnectivity());
  if(result == ConnectivityResult.none){
    return false;
  }
  else{
    return true;
  }
}

Future showToast(String message){
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0
  );
}

OutlineInputBorder focusedBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: HexColor("#F9F9FE"),
    ),
    borderRadius: BorderRadius.circular(16),
  );
}

OutlineInputBorder disabledBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.circular(16),
  );
}

OutlineInputBorder errorBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.red,
    ),
    borderRadius: BorderRadius.circular(16),
  );
}

OutlineInputBorder enabledBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
        color: HexColor("#F9F9FE"),
    ),
    borderRadius: BorderRadius.circular(16),
  );
}

String formatMoney(double amount) {
  final formatter = NumberFormat('#,##0.0', 'en_US');
  return formatter.format(amount);
}

bool isEmailValid(String email) {
  final RegExp emailPattern = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailPattern.hasMatch(email);
}

Future<List<Category>> getCategories () async {

  var db_helper = DbHelper();
  List<Category> categoryList = await db_helper.getCategories();


  return categoryList;
}

