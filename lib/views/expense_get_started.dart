import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/views/create_account.dart';
import 'package:flutter/material.dart';

class ExpenseGetStarted extends StatefulWidget {
  @override
  State<ExpenseGetStarted> createState() => _ExpenseGetStartedState();
}

class _ExpenseGetStartedState extends State<ExpenseGetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor("#206CDF"),
        title: Image.asset("assets/images/_icon.png", width: 50, height: 50,),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(15),
        color: HexColor("#206CDF"),
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                Image.asset("assets/images/pie.png", width: 160, height: 160,),
                Container(width: 20,),
              ],
            ),
            Container(
              height: 10,
            ),
            Text(
              "Your Pocket\nFriendly Finance\nManagement App",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                fontFamily: 'satoshi-bold',
                color: Colors.white,
              ),
            ),
            Container(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Budget, Track and manage your finances effortlessly",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'satoshi-medium',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: HexColor("#206CDF"),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                height: 45,
                color: HexColor("#FFFFFF"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccount()));
                },
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                elevation: 5,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                    ),
                    Text(
                      "Create an account",
                      style: TextStyle(
                        color: HexColor("#206CDF"),
                        fontFamily: 'satoshi-medium',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  primary: HexColor("#206CDF"),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0), // Border radius
                    side: BorderSide(
                        color: Colors.white,
                        width: 1.0), // Border color and width
                  ),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: HexColor("#FFFFFF"),
                    fontFamily: 'inter-medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(height: 20,)
          ],
        ),
      ),
    );
  }
}
