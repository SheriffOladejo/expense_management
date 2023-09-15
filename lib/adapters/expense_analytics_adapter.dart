import 'package:expense_management/models/category.dart';
import 'package:flutter/material.dart';

class ExpenseAnalyticAdapter extends StatefulWidget {

  Category category;
  ExpenseAnalyticAdapter({
    this.category,
  });

  @override
  State<ExpenseAnalyticAdapter> createState() => _ExpenseAnalyticAdapterState();

}

class _ExpenseAnalyticAdapterState extends State<ExpenseAnalyticAdapter> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(width: 5,),
          Text(widget.category.emoji),
          Container(width: 5,),
          Text(widget.category.title, style: TextStyle(
            color: Colors.black,
            fontFamily: 'inter-regular',
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),),
          Container(width: 110,),
          Text("#${widget.category.budget}", style: TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontFamily: 'satoshi-regular',
            fontWeight: FontWeight.w600,
          ),),
          Spacer(),
          Text("#${widget.category.spent}", style: TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontFamily: 'satoshi-regular',
            fontWeight: FontWeight.w600,
          ),),
          Container(width: 8,),
        ],
      ),
    );
  }

}
