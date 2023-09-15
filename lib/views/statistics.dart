import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/views/bar_chart.dart';
import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {

  @override
  State<Statistics> createState() => _StatisticsState();

}

class _StatisticsState extends State<Statistics> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    height: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: HexColor("#4897FA")
                    ),
                    child: BarChartSample3(),
                  ),
                  Container(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Expense analytics",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'satoshi-bold'),
                    ),
                  ),
                  Container(
                    height: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "You spent #1000 more than last week",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'satoshi-bold'),
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Category", style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'satoshi-regular',
                        fontWeight: FontWeight.w600,
                      ),),
                      Container(width: 80,),
                      Text("Budget", style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'satoshi-regular',
                        fontWeight: FontWeight.w600,
                      ),),
                      Text("Spent", style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'satoshi-regular',
                        fontWeight: FontWeight.w600,
                      ),),
                    ],
                  )
                ])),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: 500,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 12,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {

                      }),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

}
