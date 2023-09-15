import 'package:expense_management/models/category.dart';
import 'package:flutter/material.dart';

class CategoryAdapter extends StatelessWidget {

  Category category;
  CategoryAdapter({this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: Colors.grey
        ),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      margin: const EdgeInsets.only(left: 5, right: 5),
      width: 80,
      height: 50,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Text(category.emoji),
          Container(height: 5,),
          Text(category.title, style: TextStyle(
            color: Colors.black,
            fontFamily: 'inter-regular',
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),)
        ],
      ),
    );
  }

}
