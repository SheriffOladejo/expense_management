import 'package:expense_management/models/category.dart';
import 'package:expense_management/utils/methods.dart';
import 'package:flutter/material.dart';

class ExpenseAnalyticAdapter extends StatefulWidget {

  Category category;
  String currency;
  ExpenseAnalyticAdapter({
    this.category,
    this.currency,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: 5,),
          Text(widget.category.emoji),
          Container(width: 5,),
          Container(
            width: 100,
            child: Text(widget.category.title, style: TextStyle(
              color: Colors.black,
              fontFamily: 'inter-regular',
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),),
          ),
          Container(
            alignment: Alignment.center,
            width: 100,
            child: Text("${widget.currency} ${formatMoney(widget.category.budget)}", style: TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontFamily: 'satoshi-regular',
              fontWeight: FontWeight.w600,
            ),),
          ),
          Container(
            alignment: Alignment.centerRight,
            width: 100,
            child: Text("${widget.currency} ${formatMoney(widget.category.spent)}", style: TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontFamily: 'satoshi-regular',
              fontWeight: FontWeight.w600,
            ),),
          ),
          Container(width: 8,),
        ],
      ),
    );
  }

}
