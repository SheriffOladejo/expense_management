import 'package:expense_management/models/pie_desc_item.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:flutter/material.dart';

class PieDesc extends StatefulWidget {

  PieDescItem item;
  PieDesc({
    this.item
  });

  @override
  State<PieDesc> createState() => _PieDescState();

}

class _PieDescState extends State<PieDesc> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      margin: const EdgeInsets.only(top: 2),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: widget.item.color
            ),
          ),
          Container(width: 10,),
          Text(widget.item.category, style: TextStyle(
            color: HexColor("#667085"),
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: 'satoshi-regular',
          ),),
          Spacer(),
          Text('#${widget.item.total_spent.toStringAsFixed(1)}', style: TextStyle(
            color: HexColor("#667085"),
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: 'satoshi-regular',
          ),),
          Container(width: 15,)
        ],
      ),
    );
  }

}
