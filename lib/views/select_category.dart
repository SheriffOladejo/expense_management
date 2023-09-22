import 'package:expense_management/adapters/category_adapter2.dart';
import 'package:expense_management/models/category.dart';
import 'package:expense_management/utils/methods.dart';
import 'package:expense_management/views/add_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectCategory extends StatefulWidget {

  @override
  State<SelectCategory> createState() => _SelectCategoryState();

}

class _SelectCategoryState extends State<SelectCategory> {

  List categoryList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Select category", style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'satoshi-bold',
          fontWeight: FontWeight.w600,
        ),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          color: Colors.white,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddCategory(callback: callback, from: "select_category",)));
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  child: Text("➕   Add category", style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'inter-regular',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),)
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 200,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: categoryList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return CategoryAdapter2(category: categoryList[index]);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> callback (String emoji, String title, double budget, int id) async {
    var cat = Category(
      emoji: emoji,
      title: title,
      budget: budget,
      id: id,
      spent: 0,
    );
    categoryList.add(cat);
    setState(() {

    });
  }

  Future<void> init () async {
    categoryList = await getCategories();
    setState(() {

    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

}
