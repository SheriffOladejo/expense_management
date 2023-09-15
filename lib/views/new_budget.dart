import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/views/all_set.dart';
import 'package:expense_management/views/allocate_budget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewBudget extends StatefulWidget {

  @override
  State<NewBudget> createState() => _NewBudgetState();

}

class _NewBudgetState extends State<NewBudget> {

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final budgetController = TextEditingController();
  final balanceController = TextEditingController();

  String currency = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("New Budget", style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'satoshi-bold',
          fontWeight: FontWeight.w600,
        ),),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () {

          },
          child: Icon(CupertinoIcons.chevron_left, color: Colors.black,),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text("Start Date", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                fontFamily: 'satoshi-medium',
              ),),
            ),
            Container(height: 5,),
            Container(
              height: 50,
              child: TextFormField(
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'satoshi-medium',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                controller: startDateController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey,
                  ),
                  hintText: 'dd-mm-yyyy',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'satoshi-medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: HexColor("#D0D5DD")),
                  ),
                ),
              ),
            ),
            Container(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text("End Date", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                fontFamily: 'satoshi-medium',
              ),),
            ),
            Container(height: 5,),
            Container(
              height: 50,
              child: TextFormField(
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'satoshi-medium',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                controller: endDateController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey,
                  ),
                  hintText: 'dd-mm-yyyy',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'satoshi-medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: HexColor("#D0D5DD")),
                  ),
                ),
              ),
            ),
            Container(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text("Initial balance", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                fontFamily: 'satoshi-medium',
              ),),
            ),
            Container(height: 5,),
            Container(
              height: 50,
              child: TextFormField(
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'satoshi-medium',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                controller: balanceController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey,
                  ),
                  hintText: '\$ 0.0',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'satoshi-medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: HexColor("#D0D5DD")),
                  ),
                ),
              ),
            ),
            Container(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text("Budget", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                fontFamily: 'satoshi-medium',
              ),),
            ),
            Container(height: 5,),
            Container(
              height: 50,
              child: TextFormField(
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'satoshi-medium',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                controller: budgetController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey,
                  ),
                  hintText: '\$ 0.0',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'satoshi-medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: HexColor("#D0D5DD")),
                  ),
                ),
              ),
            ),
            Container(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                height: 45,
                color: HexColor("#206CDF"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AllocateBudget()));
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
                      "Continue",
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
