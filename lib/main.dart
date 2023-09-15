import 'dart:io';

import 'package:expense_management/views/expense_bottom_nav.dart';
import 'package:expense_management/views/expense_get_started.dart';
import 'package:expense_management/views/home_page.dart';
import 'package:expense_management/views/wallet_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpenseGetStarted()
    );
  }
}
