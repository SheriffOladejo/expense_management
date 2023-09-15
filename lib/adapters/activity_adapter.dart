import 'package:expense_management/models/activity.dart';
import 'package:expense_management/models/category.dart';
import 'package:flutter/material.dart';

class ActivityAdapter extends StatefulWidget {

  Activity activity;
  ActivityAdapter({
    this.activity
  });

  @override
  State<ActivityAdapter> createState() => _ActivityAdapterState();

}

class _ActivityAdapterState extends State<ActivityAdapter> {

  Category category = Category(emoji: "🛒", title: "Groceries");

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(category.emoji),
          Container(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Fish and garri", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontFamily: 'satoshi-medium'
              ),),
              Container(height: 3,),
              Text("Today, 12:30pm", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  fontFamily: 'satoshi-regular'
              ),),
            ],
          ),
          Spacer(),
          Container(
            margin: const EdgeInsets.only(right: 30),
            height: 50,
            width: 50,
            alignment: Alignment.topLeft,
            child: Text("-\$200", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontFamily: 'satoshi-medium'
            ),),
          ),
        ],
      ),
    );
  }

}
