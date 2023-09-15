import 'package:expense_management/models/wallet.dart';
import 'package:expense_management/utils/db_helper.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/views/bottom_nav.dart';
import 'package:expense_management/views/bottom_nav2.dart';
import 'package:expense_management/views/expense_get_started.dart';
import 'package:expense_management/views/get_started_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WalletSplash extends StatefulWidget {

  const WalletSplash({Key key}) : super(key: key);

  @override
  State<WalletSplash> createState() => _WalletSplashState();

}

class _WalletSplashState extends State<WalletSplash> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#0F0F0F"),
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: HexColor("#0F0F0F"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/_icon.png", width: 100, height: 100,),
          ],
        ),
      ),
    );
  }

  Future<void> init () async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ExpenseGetStarted()));
  }

  Future<bool> checkAppStoreApproval () async {
    final snapshot = await FirebaseDatabase.instance.ref().child('data/AppStoreApproval').get();
    final val = snapshot.value.toString();
    if (val == "no") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav2()));
    }
    else if (val == "yes") {
      DbHelper db = DbHelper();
      List<Wallet> l = await db.getWallets();
      if (l.isEmpty) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetStartedScreen()));
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNav()));
      }
    }
  }



  @override void initState () {
    super.initState();
    init();
  }

}
