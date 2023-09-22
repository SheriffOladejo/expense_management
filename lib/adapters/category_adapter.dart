import 'package:expense_management/models/category.dart';
import 'package:flutter/material.dart';

class CategoryAdapter extends StatefulWidget {

  Category category;
  Function callback;
  Function catCallback;

  CategoryAdapter({this.category, this.callback, this.catCallback});

  @override
  State<CategoryAdapter> createState() => _CategoryAdapterState();

}

class _CategoryAdapterState extends State<CategoryAdapter> {


  @override
  Widget build(BuildContext context) {
    bool is_selected = false;
    Category cat = widget.callback();
    if (cat != null) {
      if (cat.id == widget.category.id) {
        is_selected = true;
      }
    }
    return GestureDetector(
      onTap: () {
        is_selected = !is_selected;
        if (!is_selected) {
          widget.catCallback(null);
        }
        else {
          widget.catCallback(widget.category);
        }
        setState(() {

        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: is_selected ? 1 : 0.5,
              color: is_selected ? Colors.blue : Colors.grey
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        margin: const EdgeInsets.only(left: 5, right: 5),
        width: 80,
        height: 50,
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Text(widget.category.emoji),
            Container(height: 5,),
            Text(widget.category.title, style: TextStyle(
              color: Colors.black,
              fontFamily: 'inter-regular',
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),)
          ],
        ),
      ),
    );
  }

}

