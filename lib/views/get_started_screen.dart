import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/views/secret_phrase.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatefulWidget {

  const GetStartedScreen({Key key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();

}

class _GetStartedScreenState extends State<GetStartedScreen> {

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
      bottomSheet: Container(
        color: HexColor("#0F0F0F"),
        width: MediaQuery.of(context).size.width,
        height: 70,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: 20),
        child: MaterialButton(
          color: HexColor("#194D9B"),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SecretPhrase(callback: null,)));
          },
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3))
          ),
          elevation: 5,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 10,),
              Image.asset("assets/images/import-wallet.png", width: 24, height: 24,),
              Container(width: 10,),
              const Text("Import a new wallet", style: TextStyle(
                color: Colors.white,
                fontFamily: 'inter-medium',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),),
              Container(width: 10,),
            ],
          ),
        ),
      ),
    );
  }

}
