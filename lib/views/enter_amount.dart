import 'package:expense_management/models/category.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnterAmount extends StatefulWidget {

  Category category;
  EnterAmount({this.category});

  @override
  State<EnterAmount> createState() => _EnterAmountState();

}

class _EnterAmountState extends State<EnterAmount> {

  final itemController = TextEditingController();
  final amountController = TextEditingController();
  final budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Enter amount", style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'satoshi-bold',
          fontWeight: FontWeight.w600,
        ),),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(CupertinoIcons.chevron_left, color: Colors.black,),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(15),
        color: Colors.white,
        child: Column(
          children: [
            Container(height: 10,),
            Text("What did you spend money on? Enter a name of the item and the amount spent on it", style: TextStyle(
                fontFamily: 'satoshi-medium',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey
            ),),
            Container(height: 30,),
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
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  //contentPadding: EdgeInsets.all(15.0),
                  hintText: '\#200.0',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'satoshi-medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  suffix: GestureDetector(
                    onTap: () {
                      
                    },
                    child: IconButton(
                      icon: Image.asset('assets/images/edit.png', width: 16, height: 16,), // Use the asset path
                      onPressed: () {

                      },
                    )
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: HexColor("#D0D5DD")),
                  ),
                ),
              ),
            ),
            Container(height: 5,),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text("Item", style: TextStyle(
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
                controller: itemController,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  //contentPadding: EdgeInsets.all(15.0),
                  hintText: 'Ex. Sausages',
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
              child: Text("Amount spent", style: TextStyle(
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
                controller: amountController,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  //contentPadding: EdgeInsets.all(15.0),
                  hintText: '\$0.0',
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
          ],
        ),
      ),
      bottomSheet: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 45),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            height: 45,
            color: HexColor("#206CDF"),
            onPressed: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
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
                  "Done",
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
      ),
    );
  }

}
