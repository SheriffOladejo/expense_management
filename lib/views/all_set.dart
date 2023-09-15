import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/views/expense_bottom_nav.dart';
import 'package:expense_management/views/home_page.dart';
import 'package:flutter/material.dart';

class AllSet extends StatefulWidget {

  @override
  State<AllSet> createState() => _AllSetState();

}

class _AllSetState extends State<AllSet> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/all_set.png", width: 200, height: 200,),
            Container(height: 45,),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                height: 45,
                color: HexColor("#206CDF"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ExpenseBottomNav()));
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
                      "Proceed to homepage",
                      style: TextStyle(
                        color: HexColor("#ffffff"),
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
          ],
        ),
      ),
    );
  }

}
