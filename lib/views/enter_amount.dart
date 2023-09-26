import 'package:expense_management/models/activity.dart';
import 'package:expense_management/models/budget.dart';
import 'package:expense_management/models/category.dart';
import 'package:expense_management/models/user.dart';
import 'package:expense_management/utils/db_helper.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/views/expense_bottom_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnterAmount extends StatefulWidget {

  Category category;

  EnterAmount({this.category});

  @override
  State<EnterAmount> createState() => _EnterAmountState();

}

class _EnterAmountState extends State<EnterAmount> {

  final itemController = TextEditingController(text: "test");
  final amountController = TextEditingController(text: "3");
  final budgetController = TextEditingController();

  var db_helper = DbHelper();
  Budget budget;
  double balance;
  double total_spent = 0;
  double remaining;
  User user;
  bool isEditing = false;
  bool isLoading = false;

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Form(
        key: form,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(15),
            color: Colors.white,
            child: isLoading ? Center(child: CircularProgressIndicator(),) : Column(
              children: [
                Container(height: 10,),
                Text("What did you spend money on? Enter a name of the item and the amount spent on it\n${isEditing ? "Budget balance: ${user.currency} ${remaining.toStringAsFixed(1)}" : ""}", style: TextStyle(
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
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'satoshi-medium',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          controller: budgetController,
                          validator: (value) {
                            if (budgetController.text.isNotEmpty) {
                              if (double.parse(budgetController.text) > remaining) {
                                return "Cannot exceed overall budget";
                              }
                            }
                            return null;
                          },
                          textAlignVertical: TextAlignVertical.center,
                          readOnly: !isEditing,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: InputDecoration(
                            hintText: '${user.currency} ${widget.category.budget.toStringAsFixed(1)}',
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
                      IconButton(
                        icon: Image.asset('assets/images/edit.png'), // Use the asset path
                        onPressed: () {
                          setState(() {
                            isEditing = !isEditing;
                          });
                        },
                      ),
                    ],
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
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
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      //contentPadding: EdgeInsets.all(15.0),
                      hintText: '${user.currency} 0.0',
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
              if (form.currentState.validate()) {
                await saveActivity();
                Navigator.pop(context);
              }
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

  Future<void> saveActivity () async {
    setState(() {
      isLoading = true;
    });
    if (isEditing && double.parse(budgetController.text) != widget.category.budget) {
      widget.category.budget = double.parse(budgetController.text);
      await db_helper.updateCategory(widget.category);
    }
    var act = Activity(
      id: DateTime.now().millisecondsSinceEpoch,
      amount: double.parse(amountController.text),
      category_id: widget.category.id,
      title: itemController.text,
      time: DateTime.now().millisecondsSinceEpoch
    );
    await db_helper.saveActivity(act);
    setState(() {
      isLoading = false;
    });
  }

  void init () async {
    setState(() {
      isLoading = true;
    });
    user = await db_helper.getUser();
    List<Budget> budgets = await db_helper.getBudgets();
    for (var i = 0; i < budgets.length; i++) {
      if (budgets[i].endDate > DateTime.now().millisecondsSinceEpoch) {
        budget = budgets[i];
      }
    }
    List<Category> categories = await db_helper.getCategories();
    remaining = budget.budget;
    for (var i = 0; i < categories.length; i++) {
      remaining -= categories[i].budget;
    }
    balance = budget.initialBalance;
    balance = balance - total_spent;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState () {
    init();
    super.initState();
  }

}
