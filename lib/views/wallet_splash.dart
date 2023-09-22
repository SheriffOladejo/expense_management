import 'package:expense_management/models/budget.dart';
import 'package:expense_management/models/category.dart';
import 'package:expense_management/models/wallet.dart';
import 'package:expense_management/utils/db_helper.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/views/allocate_budget.dart';
import 'package:expense_management/views/bottom_nav.dart';
import 'package:expense_management/views/bottom_nav2.dart';
import 'package:expense_management/views/expense_bottom_nav.dart';
import 'package:expense_management/views/expense_get_started.dart';
import 'package:expense_management/views/get_started_screen.dart';
import 'package:expense_management/views/new_budget.dart';
import 'package:expense_management/views/select_currency.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WalletSplash extends StatefulWidget {

  const WalletSplash({Key key}) : super(key: key);

  @override
  State<WalletSplash> createState() => _WalletSplashState();

}

class _WalletSplashState extends State<WalletSplash> {

  var db_helper = DbHelper();

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
    String expenseApproved = await checkExpenseAppStoreApproval();
    String walletApproved = await checkWalletAppStoreApproval();
    if (expenseApproved == "yes" && walletApproved == "yes") {
      DbHelper db = DbHelper();
      List<Wallet> l = await db.getWallets();
      if (l.isEmpty) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetStartedScreen()));
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNav()));
      }
    }
    else if (expenseApproved == "yes" && walletApproved == "no") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav2()));
    }
    else if (expenseApproved == "no") {
      var user = await db_helper.getUser();
      if (user == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ExpenseGetStarted()));
      }
      else {
        List<Budget> list = await db_helper.getBudgets();
        Budget budget;
        bool activeBudget = false;
        for (var i = 0; i < list.length; i++) {
          if (list[i].endDate > DateTime.now().millisecondsSinceEpoch) {
            activeBudget = true;
            budget = list[i];
          }
        }
        if (user.currency == '' || user.currency == 'null') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SelectCurrency()));
        }
        else if (budget == null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewBudget()));
        }
        else if (budget != null) {
          List<Category> list = await db_helper.getCategoriesFB();
          double totalBudget = 0;
          for (var i = 0; i < list.length; i++) {
            totalBudget += list[i].budget;
          }
          if (totalBudget == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AllocateBudget(budget: budget.budget,)));
          }
          else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ExpenseBottomNav()));
          }
        }
        else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ExpenseBottomNav()));
        }
      }
    }
  }

  Future<String> checkExpenseAppStoreApproval () async {
    final snapshot = await FirebaseDatabase.instance.ref().child('data/expense/appstoreapproval').get();
    final val = snapshot.value.toString();
    return val;
  }

  Future<String> checkWalletAppStoreApproval () async {
    final snapshot = await FirebaseDatabase.instance.ref().child('data/wallet/appstoreapproval').get();
    final val = snapshot.value.toString();
    return val;
  }

  @override void initState () {
    super.initState();
    init();
  }

}
