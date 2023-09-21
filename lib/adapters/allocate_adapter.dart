import 'package:expense_management/models/category.dart';
import 'package:expense_management/utils/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AllocateAdapter extends StatefulWidget {

  Category category;
  Function removeCallback;
  double budget;
  double totalBudget;
  String currency;

  AllocateAdapter({
    this.category,
    this.totalBudget,
    this.removeCallback,
    this.currency,
  });

  @override
  State<AllocateAdapter> createState() => _AllocateAdapterState();

}

class _AllocateAdapterState extends State<AllocateAdapter> {

  final budgetController = TextEditingController(text: "1");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Text(widget.category.emoji),
          Container(width: 10,),
          Text(widget.category.title, style: TextStyle(
            color: Colors.black,
            fontFamily: 'inter-regular',
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),),
          Spacer(),
          Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0), // Adjust the radius as needed
              border: Border.all(
                color: Colors.grey, // Border color
                width: 1.0, // Border width
              ),
            ),
            child: TextFormField(
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontFamily: 'satoshi-regular',
                color: Colors.black
              ),
              onChanged: (value) {
                if (double.parse(value) > widget.totalBudget) {
                  showToast("${widget.category.title} budget cannot be more than total budget");
                }
                else {
                  widget.budget = double.parse(value);
                }
              },
              keyboardType: TextInputType.number, // This sets the keyboard type to numeric
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Only allow numeric input
              ],
              decoration: InputDecoration(
                hintText: '${widget.currency} 0.0',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontFamily: 'satoshi-regular',
                  color: Colors.grey
                ),
                contentPadding: const EdgeInsets.only(left: 10, bottom: 10),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(width: 30,),
          GestureDetector(
            onTap: () async {
              await widget.removeCallback(widget.category.id);
            },
            child: Icon(Icons.close, color: Colors.black,),
          ),
          Container(width: 10,),
        ],
      ),
    );
  }

  double getBudget () {
    if (budgetController.text.isNotEmpty) {
      return double.parse(budgetController.text);
    }
    return 0;
  }

}
