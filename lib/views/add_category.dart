import 'package:expense_management/models/activity.dart';
import 'package:expense_management/models/budget.dart';
import 'package:expense_management/models/category.dart';
import 'package:expense_management/utils/db_helper.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/views/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCategory extends StatefulWidget {

  Function callback;
  String from;
  AddCategory({
    this.callback,
    this.from,
  });

  @override
  State<AddCategory> createState() => _AddCategoryState();

}

class _AddCategoryState extends State<AddCategory> {

  final emojiController = TextEditingController();
  final nameController = TextEditingController();
  final budgetController = TextEditingController();

  Budget budget;
  double remaining;
  var db_helper = DbHelper();

  var user;

  final form = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Add category", style: TextStyle(
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
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(15),
          color: Colors.white,
          child: isLoading ? Center(child: CircularProgressIndicator(),) : Column(
            children: [
              Container(height: 10,),
              Text("Create a name and preferred emoji to identify the category\nBudget balance: ${user.currency} ${remaining.toStringAsFixed(1)}", style: TextStyle(
                fontFamily: 'satoshi-medium',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey
              ),),
              Container(height: 30,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text("Category name", style: TextStyle(
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
                  controller: nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    //contentPadding: EdgeInsets.all(15.0),
                    hintText: 'Ex. Charity',
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
                child: Text("Emoji", style: TextStyle(
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
                  controller: emojiController,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    //contentPadding: EdgeInsets.all(15.0),
                    hintText: '🤝',
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Required";
                    }
                    else if (double.parse(budgetController.text) > remaining) {
                      return "Cannot exceed current overall budget";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  controller: budgetController,
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
      bottomSheet: Container(
        height: 50,
        margin: const EdgeInsets.only(bottom: 45),
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            height: 45,
            color: HexColor("#206CDF"),
            onPressed: () async {
              if (form.currentState.validate()) {
                int id = DateTime.now().millisecondsSinceEpoch;
                await saveCategory(id);
                if (widget.from == "select_category") {
                  await widget.callback(emojiController.text,
                      nameController.text.replaceRange(0, 1, nameController.text.substring(0, 1).toUpperCase()),
                      double.parse(budgetController.text),
                      id
                  );
                }
                else if (widget.from == "allocate_budget") {
                  await widget.callback(emojiController.text, nameController.text.replaceRange(0, 1, nameController.text.substring(0, 1).toUpperCase()));
                }
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

  Future<void> saveCategory (int id) async {
    Category cat = Category(
      id: id,
      spent: 0,
      budget: double.parse(budgetController.text),
      title: nameController.text.replaceRange(0, 1, nameController.text.substring(0, 1).toUpperCase()),
      emoji: emojiController.text,
    );
    var db_helper = DbHelper();
    await db_helper.saveCategory(cat);
  }

  Future<void> init () async {
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
