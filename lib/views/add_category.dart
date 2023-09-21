import 'package:expense_management/models/category.dart';
import 'package:expense_management/utils/db_helper.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/views/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {

  Function callback;
  AddCategory({
    this.callback,
  });

  @override
  State<AddCategory> createState() => _AddCategoryState();

}

class _AddCategoryState extends State<AddCategory> {

  final emojiController = TextEditingController();
  final nameController = TextEditingController();

  final form = GlobalKey<FormState>();

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
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(15),
          color: Colors.white,
          child: Column(
            children: [
              Container(height: 10,),
              Text("Create a name and preferred emoji to identify the category", style: TextStyle(
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
                await saveCategory();
                await widget.callback(emojiController.text, nameController.text.replaceRange(0, 1, nameController.text.substring(0, 1).toUpperCase()));
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

  Future<void> saveCategory () async {
    Category cat = Category(
      id: DateTime.now().millisecondsSinceEpoch,
      spent: 0,
      budget: 0,
      title: nameController.text.replaceRange(0, 1, nameController.text.substring(0, 1).toUpperCase()),
      emoji: emojiController.text,
    );
    var db_helper = DbHelper();
    await db_helper.saveCategory(cat);
  }

}
