import 'package:expense_management/adapters/allocate_adapter.dart';
import 'package:expense_management/models/budget.dart';
import 'package:expense_management/models/category.dart';
import 'package:expense_management/models/user.dart';
import 'package:expense_management/utils/db_helper.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/utils/methods.dart';
import 'package:expense_management/views/add_category.dart';
import 'package:expense_management/views/all_set.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllocateBudget extends StatefulWidget {

  double budget;
  AllocateBudget({
    this.budget,
  });

  @override
  State<AllocateBudget> createState() => _AllocateBudgetState();

}

class _AllocateBudgetState extends State<AllocateBudget> {

  List<AllocateAdapter> adapterList = [];
  List<Category> categoryList = [];

  double total_budget = 0;

  var db_helper = DbHelper();
  User user;

  String currency = "";

  bool isLoading = false;

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
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        color: Colors.white,
        child: isLoading ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddCategory(callback: callback, from: "allocate_budget",)));
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
                children: adapterList,
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
            onPressed: () async {
              await saveAllocations();
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

  Future<void> callback (String emoji, String title) {
    var cat = Category(
      emoji: emoji,
      title: title,
      budget: 0,
      id: DateTime.now().millisecondsSinceEpoch,
      spent: 0,
    );
    categoryList.add(
      cat
    );
    adapterList.add(AllocateAdapter(category: cat, removeCallback: removeCallback,));
    setState(() {

    });
  }

  Future<void> removeCallback (int id) async {
    var user = await db_helper.getUser();
    adapterList.removeWhere((element) {
      return element.category.id == id;
    });
    categoryList.removeWhere((element) {
      return element.id == id;
    });
    await db_helper.deleteCategory(id);
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('data/users/${user.id}/categories/$id');
    setState(() {

    });
    await databaseReference.remove();
  }

  Future<void> saveAllocations () async {
    bool isEmpty = false;
    total_budget = 0;
    for (var i = 0; i < adapterList.length; i++) {
      if (adapterList[i].budget != null) {
        total_budget += adapterList[i].budget;
      }
      else if (adapterList[i].budget == null) {
        isEmpty = true;
      }
    }
    if (isEmpty) {
      showToast("Budgets should be assigned");
    }
    else {
      if (total_budget > widget.budget) {
        showToast("Budget is greater than total budget assigned");
      }
      else if (total_budget == 0) {
        showToast("Set budgets");
      }
      else {
        for (var i = 0; i < adapterList.length; i++) {
          var cat = Category(
            id: adapterList[i].category.id,
            spent: adapterList[i].category.spent,
            budget: adapterList[i].budget,
          );
          await db_helper.updateCategory(cat);
        }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AllSet()));
      }
    }
  }

  Future<void> init () async {
    setState((){
      isLoading = true;
    });
    categoryList = await getCategories();
    user = await db_helper.getUser();
    currency = user.currency;
    for (var i = 0; i < categoryList.length; i++) {
      adapterList.add(AllocateAdapter(
        category: categoryList[i],
        removeCallback: removeCallback,
        totalBudget: widget.budget,
        currency: currency,
      ));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

}
