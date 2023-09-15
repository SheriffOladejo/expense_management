import 'package:expense_management/adapters/expense_analytics_adapter.dart';
import 'package:expense_management/models/category.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/views/bar_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {

  @override
  State<Statistics> createState() => _StatisticsState();

}

class _StatisticsState extends State<Statistics> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Statistics", style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'satoshi-bold',
          fontWeight: FontWeight.w600,
        ),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
                  Stack(
                    children: [
                      Container(
                          margin: const EdgeInsets.all(15),
                          padding: const EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          height: 400,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              color: HexColor("#4897FA")
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: BarChartSample3()
                          ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20, right: 30),
                            height: 50,
                            alignment: Alignment.centerRight,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: HexColor("#4DFFFFFF"),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(24))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Sep 2023",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'satoshi-regular',
                                        ),
                                      ),
                                      Container(
                                        width: 5,
                                      ),
                                      Icon(
                                        CupertinoIcons.chevron_down,
                                        size: 12,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Text(
                              "-20% from yesterday",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'satoshi-regular',
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    child: const Text(
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
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "You spent ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'satoshi-bold',
                            ),
                          ),
                          TextSpan(
                            text: "#1000",
                            style: TextStyle(
                              color: Colors.red, // Set the text color to red
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'satoshi-bold',
                            ),
                          ),
                          TextSpan(
                            text: " more than last week",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'satoshi-bold',
                            ),
                          ),
                        ],
                      ),
                    )

                  ),
                  Container(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(width: 16,),
                      const Text("Category", style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'satoshi-regular',
                        fontWeight: FontWeight.w600,
                      ),),
                      Container(width: 120,),
                      const Text("Budget", style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'satoshi-regular',
                        fontWeight: FontWeight.w600,
                      ),),
                      const Spacer(),
                      const Text("Spent", style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'satoshi-regular',
                        fontWeight: FontWeight.w600,
                      ),),
                      Container(width: 20,),
                    ],
                  ),
                  const Divider(),
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
                        return ExpenseAnalyticAdapter(
                          category: Category(emoji: "⛽️", title: "Fuel", budget: 250, spent: 45),
                        );
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
