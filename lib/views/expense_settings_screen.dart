import 'package:expense_management/models/user.dart';
import 'package:expense_management/utils/db_helper.dart';
import 'package:expense_management/views/expense_get_started.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/utils/methods.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpenseSettingsScreen extends StatefulWidget {
  const ExpenseSettingsScreen({Key key}) : super(key: key);

  @override
  State<ExpenseSettingsScreen> createState() => _ExpenseSettingsScreenState();
}

class _ExpenseSettingsScreenState extends State<ExpenseSettingsScreen> {

  final db_helper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#ffffff"),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text("Settings",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'satoshi-bold',
              fontSize: 16,
            )),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: HexColor("#ffffff"),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                var url = "https://docs.google.com/document/d/1guzj0NLZgtUnSX-O5nEMXdzyFj71uflkrbC39-bIUFk/edit?usp=sharing";
                if(await canLaunch(url)){
                  await launch(url);
                }
                else{
                  showToast("Cannot launch URL");
                }
              },
              child: Container(
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: HexColor("#ffffff"),
                ),
                child: Row(
                  children: [
                    Container(width: 15,),
                    Image.asset("assets/images/privacy_policy.png", color: Colors.black,),
                    Container(width: 10,),
                    Text("Privacy policy", style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'satoshi-regular',
                    ),),
                  ],
                ),
              ),
            ),
            Container(height: 15,),
            GestureDetector(
              onTap: () async {
                var url = "https://docs.google.com/document/d/1E4gsoIfHJfkSBoz1VOcFdSMlKX8haWL4On8vH-_QtuY/edit?usp=sharing";
                if(await canLaunch(url)){
                  await launch(url);
                }
                else{
                  showToast("Cannot launch URL");
                }
              },
              child: Container(
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: HexColor("#ffffff"),
                ),
                child: Row(
                  children: [
                    Container(width: 15,),
                    Image.asset("assets/images/terms_of_use.png", color: Colors.black,),
                    Container(width: 10,),
                    Text("Terms of use", style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'satoshi-regular',
                    ),),
                  ],
                ),
              ),
            ),
            Container(height: 15,),
            GestureDetector(
              onTap: () async {
                await showDialog(context: context, builder: (_) {return ConfirmationDialog(onConfirm: deleteAccount,);});
              },
              child: Container(
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: HexColor("#ffffff"),
                ),
                child: Row(
                  children: [
                    Container(width: 15,),
                    Image.asset("assets/images/delete.png", color: Colors.black, width: 24, height: 24,),
                    Container(width: 10,),
                    Text("Delete account", style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'inter-regular',
                    ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteAccount () async {
    showToast("Deleting account please wait");
    User user = await db_helper.getUser();
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('data/users/${user.id}');
    await databaseReference.remove();
    await db_helper.deleteTables();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ExpenseGetStarted()));
  }

}

class ConfirmationDialog extends StatelessWidget {
  final Function onConfirm;

  ConfirmationDialog({this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirm Deletion", style: TextStyle(
          color: Colors.black
      ),),
      content: Text("Are you sure you want to delete your account and data? This action cannot be undone."),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: Text("Confirm"),
        ),
      ],
    );
  }
}
