import 'dart:math';

import 'package:expense_management/adapters/expense_analytics_adapter.dart';
import 'package:expense_management/models/activity.dart';
import 'package:expense_management/models/budget.dart';
import 'package:expense_management/models/category.dart';
import 'package:expense_management/models/user.dart';
import 'package:expense_management/utils/db_helper.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/views/bar_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Statistics extends StatefulWidget {

  @override
  State<Statistics> createState() => _StatisticsState();

}

class _StatisticsState extends State<Statistics> {

  bool showDateOption = false;
  String selectedDateOption = "This week";

  List<Activity> activities;
  List<Category> categories;

  Map<String, Map<String, List<Activity>>> activityGroups = {
    'This week': {},
    'Last week': {},
    '2wks ago': {},
    '3wks ago': {},
  };

  List<String> dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  String prevDiff_ = "";
  String diffPct_ = "";
  double prevDiff = 0;
  double diffPct = 0;

  double chart_highest_spent = 0;

  LinearGradient get _barsGradient => const LinearGradient(
    colors: [
      Colors.white,
      Colors.white,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> bars_list = [];

  User user;
  Budget budget;

  final db_helper = DbHelper();

  bool isLoading = false;

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
      body: GestureDetector(
        onTap: () {
          showDateOption = false;
          setState(() {

          });
        },
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: isLoading ? const Center(child: CircularProgressIndicator(),) : CustomScrollView(
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
                              child: BarChartSample3(list: bars_list, chartHighestSpent: chart_highest_spent,)
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
                                  GestureDetector(
                                    onTap: () {
                                      showDateOption = true;
                                      setState(() {

                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: HexColor("#4DFFFFFF"),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(24))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedDateOption,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'satoshi-regular',
                                            ),
                                          ),
                                          Container(
                                            width: 5,
                                          ),
                                          const Icon(
                                            CupertinoIcons.chevron_down,
                                            size: 12,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Text(
                                diffPct >= 0 ? "+${diffPct.toStringAsFixed(1)}% from last week" : "$diffPct% from last week",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'satoshi-regular',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.only(right: 30,),
                          child: Visibility(
                            visible: showDateOption,
                            child: Container(
                              margin: const EdgeInsets.only(top: 30),
                              color: Colors.white,
                              height: 180,
                              width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(height: 10,),
                                  GestureDetector(
                                    onTap: () async {
                                      selectedDateOption = "This week";
                                      showDateOption = false;
                                      await updateChart();
                                      setState(() {

                                      });
                                    },
                                    child: const Text(
                                      "This week",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'satoshi-regular',
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  GestureDetector(
                                    onTap: () async {
                                      selectedDateOption = "Last week";
                                      showDateOption = false;
                                      await updateChart();
                                      setState(() {

                                      });
                                    },
                                    child: const Text(
                                      "Last week",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'satoshi-regular',
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  GestureDetector(
                                    onTap: () async {
                                      selectedDateOption = "2wks ago";
                                      showDateOption = false;
                                      await updateChart();
                                      setState(() {

                                      });
                                    },
                                    child: const Text(
                                      "2wks ago",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'satoshi-regular',
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  GestureDetector(
                                    onTap: () async {
                                      selectedDateOption = "3wks ago";
                                      showDateOption = false;
                                      await updateChart();
                                      setState(() {

                                      });
                                    },
                                    child: const Text(
                                      "3wks ago",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'satoshi-regular',
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                          ),
                        ),
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
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "You spent ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'satoshi-bold',
                              ),
                            ),
                            TextSpan(
                              text: "${user.currency} ${prevDiff.abs().toStringAsFixed(0)}",
                              style: TextStyle(
                                color: prevDiff < 0 ? Colors.green : Colors.red, // Set the text color to red
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'satoshi-bold',
                              ),
                            ),
                            TextSpan(
                              text: prevDiff < 0 ? " less than last week" : " more than last week",
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
                        itemCount: categories.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return ExpenseAnalyticAdapter(
                            category: categories[index],
                            currency: user.currency,
                          );
                        }),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> getBars () {
    List<BarChartGroupData> list = [];
    activityGroups[selectedDateOption].forEach((key, value) {
      double total_spent = 0;

      if (key == "Mon") {
        for (Activity activity in value) {
          total_spent += activity.amount;
          chart_highest_spent = max(chart_highest_spent, total_spent);
        }
        list.add(BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: total_spent,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ));
      }
      else if (key == "Tue") {
        for (Activity activity in value) {
          total_spent += activity.amount;
          chart_highest_spent = max(chart_highest_spent, total_spent);
        }
        list.add(BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: total_spent,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ));
      }
      else if (key == "Wed") {
        for (Activity activity in value) {
          total_spent += activity.amount;
          chart_highest_spent = max(chart_highest_spent, total_spent);
        }
        list.add(BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: total_spent,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ));
      }
      else if (key == "Thu") {
        for (Activity activity in value) {
          total_spent += activity.amount;
          chart_highest_spent = max(chart_highest_spent, total_spent);
        }
        list.add(BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: total_spent,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ));
      }
      else if (key == "Fri") {
        for (Activity activity in value) {
          total_spent += activity.amount;
          chart_highest_spent = max(chart_highest_spent, total_spent);
        }
        list.add(BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: total_spent,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ));
      }
      else if (key == "Sat") {
        for (Activity activity in value) {
          total_spent += activity.amount;
          chart_highest_spent = max(chart_highest_spent, total_spent);
        }
        list.add(BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: total_spent,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ));
      }
      else if (key == "Sun") {
        for (Activity activity in value) {
          total_spent += activity.amount;
          chart_highest_spent = max(chart_highest_spent, total_spent);
        }
        list.add(BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: total_spent,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ));
      }
    });

    return list;
  }

  void calculateDiff() {
    String prevOption = "Last week";
    double prevTotal = 0;
    double total_spent = 0;
    activityGroups[selectedDateOption].forEach((key, value) {
      if (key == "Mon") {
        for (Activity activity in value) {
          total_spent += activity.amount;
        }
      }
      else if (key == "Tue") {
        for (Activity activity in value) {
          total_spent += activity.amount;
        }
      }
      else if (key == "Wed") {
        for (Activity activity in value) {
          total_spent += activity.amount;
        }
      }
      else if (key == "Thu") {
        for (Activity activity in value) {
          total_spent += activity.amount;
        }
      }
      else if (key == "Fri") {
        for (Activity activity in value) {
          total_spent += activity.amount;
        }
      }
      else if (key == "Sat") {
        for (Activity activity in value) {
          total_spent += activity.amount;
        }
      }
      else if (key == "Sun") {
        for (Activity activity in value) {
          total_spent += activity.amount;
        }
      }
    });
    activityGroups[prevOption].forEach((key, value) {
      if (key == "Mon") {
        for (Activity activity in value) {
          prevTotal += activity.amount;
        }
      }
      else if (key == "Tue") {
        for (Activity activity in value) {
          prevTotal += activity.amount;
        }
      }
      else if (key == "Wed") {
        for (Activity activity in value) {
          prevTotal += activity.amount;
        }
      }
      else if (key == "Thu") {
        for (Activity activity in value) {
          prevTotal += activity.amount;
        }
      }
      else if (key == "Fri") {
        for (Activity activity in value) {
          prevTotal += activity.amount;
        }
      }
      else if (key == "Sat") {
        for (Activity activity in value) {
          prevTotal += activity.amount;
        }
      }
      else if (key == "Sun") {
        for (Activity activity in value) {
          prevTotal += activity.amount;
        }
      }
    });

    prevDiff = total_spent - prevTotal;
    if (prevTotal == 0) {
      diffPct = 0.0; // Avoid division by zero
    }
    diffPct = ((total_spent - prevTotal) / prevTotal) * 100.0;
  }

  int getWeekOfYear(DateTime date) {
    DateTime januaryFirst = DateTime(date.year, 1, 1);
    int days = date.difference(januaryFirst).inDays;
    int weekNumber = (days / 7).ceil();
    return weekNumber;
  }
  Future<void> groupActivities() async {
    for (String week in activityGroups.keys) {
      for (String day in dayNames) {
        activityGroups[week][day] = [];
      }
    }

    for (Activity activity in activities) {
      DateTime activityDate = DateTime.fromMillisecondsSinceEpoch(activity.time);

      String week;
      String day;

      int activityWeek = getWeekOfYear(activityDate);
      int currentWeek = getWeekOfYear(DateTime.now());

      if (activityWeek == currentWeek) {
        week = 'This week';
      } else if (activityWeek == currentWeek - 1) {
        week = 'Last week';
      } else if (activityWeek == currentWeek - 2) {
        week = '2wks ago';
      } else if (activityWeek == currentWeek - 3) {
        week = '3wks ago';
      } else {
        continue;
      }

      day = dayNames[activityDate.weekday - 1];
      activityGroups[week][day].add(activity);
    }
  }

  Future<void> groupCategories () async {
    categories = await db_helper.getCategories();
    for (var i = 0; i < categories.length; i++) {

      List<Activity> list = await db_helper.getActivityByCategory(categories[i].id);

      double total = 0;
      for (var j = 0; j < list.length; j++) {
        if (list[j].time > budget.startDate && list[j].time < budget.endDate) {
          total += list[j].amount;
        }
      }
      categories[i].spent = total;
    }
  }

  Future<void> updateChart () async {
    activities = await db_helper.getActivity();
    await groupActivities();
    await groupCategories();
    bars_list = getBars();
  }

  Future<void> init () async {
    setState(() {
      isLoading = true;
    });
    user = await db_helper.getUser();
    List<Budget> budgets = await db_helper.getBudgets();
    for (var i = 0; i < budgets.length; i++) {
      if (budgets[i].endDate > DateTime.now().millisecondsSinceEpoch) {
        budget = budgets[i];
      }
    }
    activities = await db_helper.getActivity();
    await groupActivities();
    await groupCategories();
    calculateDiff();
    bars_list = getBars();
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
