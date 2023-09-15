import 'package:expense_management/adapters/allocate_adapter.dart';
import 'package:expense_management/models/category.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/views/add_category.dart';
import 'package:expense_management/views/all_set.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllocateBudget extends StatefulWidget {

  @override
  State<AllocateBudget> createState() => _AllocateBudgetState();

}

class _AllocateBudgetState extends State<AllocateBudget> {

  List<AllocateAdapter> categoryList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Allocate budget", style: TextStyle(
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
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddCategory()));
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 10),
                  child: Text("➕   Add new field", style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'inter-regular',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),)
                ),
              ),
              Column(
                children: categoryList,
              ),
              Container(height: 160,)
            ],
          ),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => AllSet()));
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
      ),
    );
  }

  Future<void> init () {
    for (var i = 0; i < 11; i++) {
      categoryList.add(AllocateAdapter(
        category: Category(
            id: i,
            emoji: '⚡️',
            title: "Electricity",
            budget: 100.0
        ),
      ));
    }
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

}
