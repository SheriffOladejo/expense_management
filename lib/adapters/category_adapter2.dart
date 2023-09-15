import 'package:expense_management/models/category.dart';
import 'package:expense_management/views/enter_amount.dart';
import 'package:flutter/material.dart';

class CategoryAdapter2 extends StatefulWidget {

  Category category;
  CategoryAdapter2({
    this.category,
  });

  @override
  State<CategoryAdapter2> createState() => _CategoryAdapter2State();

}

class _CategoryAdapter2State extends State<CategoryAdapter2> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EnterAmount(category: widget.category,)));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: 0.1,
              color: Colors.grey
          ),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        width: 80,
        height: 50,
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Text(widget.category.emoji),
            Container(width: 5,),
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
