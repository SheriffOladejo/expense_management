import 'package:expense_management/models/activity.dart';
import 'package:expense_management/models/category.dart';
import 'package:expense_management/utils/db_helper.dart';
import 'package:expense_management/utils/methods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityAdapter extends StatefulWidget {

  Activity activity;
  ActivityAdapter({
    this.activity
  });

  @override
  State<ActivityAdapter> createState() => _ActivityAdapterState();

}

class _ActivityAdapterState extends State<ActivityAdapter> {

  Category category;
  var db_helper = DbHelper();
  var user;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    String date = formatRelativeDate(DateTime.fromMillisecondsSinceEpoch(widget.activity.time));
    return isLoading ? Container() : Container(
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
              Text(widget.activity.title, style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontFamily: 'satoshi-medium'
              ),),
              Container(height: 3,),
              Text(date, style: TextStyle(
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
            width: 100,
            alignment: Alignment.centerRight,
            child: Text("-${user.currency} ${formatMoney(widget.activity.amount)}", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 13,
                fontFamily: 'satoshi-medium'
            ),),
          ),
        ],
      ),
    );
  }

  String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      // Today
      return 'Today, ${DateFormat.jm().format(date)}';
    } else if (difference.inDays == 1) {
      // Yesterday
      return 'Yesterday, ${DateFormat.jm().format(date)}';
    } else if (difference.inDays <= 7) {
      // Within the last week
      return DateFormat.E().format(date);
    } else {
      // More than a week ago
      final weeksAgo = (difference.inDays / 7).floor();
      if (weeksAgo == 1) {
        return 'One week ago';
      } else {
        return '$weeksAgo weeks ago';
      }
    }
  }

  Future<void> init () async {
    setState(() {
      isLoading = true;
    });
    user = await db_helper.getUser();
    category = await db_helper.getCategoryById(widget.activity.category_id);
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
