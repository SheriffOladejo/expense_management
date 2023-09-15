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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#ffffff"),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor("#ffffff"),
        title: Text("Settings", style: TextStyle(
          color: Colors.black,
          fontFamily: 'satoshi-bold',
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),),
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
                var url = "https://lukka.tech/privacy-policy/";
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
                var url = "https://lukka.tech/terms-of-use/";
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
          ],
        ),
      ),
    );
  }
}
