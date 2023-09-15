import 'package:expense_management/adapters/activity_adapter.dart';
import 'package:expense_management/adapters/category_adapter.dart';
import 'package:expense_management/adapters/pie_desc.dart';
import 'package:expense_management/models/category.dart';
import 'package:expense_management/models/pie_desc_item.dart';
import 'package:expense_management/models/user.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/utils/methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user;
  List categoryList = [];

  double total_spent = 0;

  final Map<String, double> dataMap = {
    "Groceries": 100.8,
    "Fuel": 160.5,
    "Food": 300.2,
    "Electricity": 240.7,
    "Internet": 80.9,
  };

  final List<PieDescItem> _dataList = [
    PieDescItem(
        id: 0, color: "#7F56D9", category: "Groceries", total_spent: 1000.0),
    PieDescItem(
      id: 1, color: "#9AE419", category: "Fuel", total_spent: 160.5
    ),
    PieDescItem(
      id: 2, color: "#F8312F", category: "Food", total_spent: 300.2
    ),
    PieDescItem(
        id: 3, color: "#4287f5", category: "Electricity", total_spent: 240.7),
    PieDescItem(
        id: 4, color: "#00C3C3", category: "Internet", total_spent: 80.9),
  ];

  final colorList = [
    HexColor("#7F56D9"),
    HexColor("#9AE419"),
    HexColor("#F8312F"),
    HexColor("#4287f5"),
    HexColor("#00C3C3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: const Text("Welcome back!",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontFamily: 'satoshi-regular',
                fontSize: 16,
              )),
        ),
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
                  height: 200,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    image: DecorationImage(
                      image: AssetImage('assets/images/home-tab-bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Balance",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'satoshi-medium',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
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
                          )
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "\$100000.98",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'satoshi-bold',
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Budget",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'satoshi-regular',
                                ),
                              ),
                              Container(
                                height: 5,
                              ),
                              const Text(
                                "\$1000.98",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'satoshi-bold',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 50,
                            color: Colors.white,
                          ),
                          Column(
                            children: [
                              const Text(
                                "Spent",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'satoshi-regular',
                                ),
                              ),
                              Container(
                                height: 5,
                              ),
                              const Text(
                                "\$500.98",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'satoshi-bold',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 16,
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                "View insight",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'satoshi-regular',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              Icon(
                                CupertinoIcons.chevron_right,
                                size: 12,
                                color: Colors.white,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Container(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'satoshi-bold'),
                  ),
                ),
                Container(
                  height: 10,
                ),
              ])),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: categoryList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryAdapter(category: categoryList[index]);
                        }),
                  ),
                  Container(
                    height: 10,
                  ),
                ]),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 160,
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              PieChart(
                                dataMap: dataMap,
                                colorList: colorList,
                                chartType: ChartType.ring,
                                chartRadius:
                                    MediaQuery.of(context).size.width / 3.2,
                                chartValuesOptions: ChartValuesOptions(
                                  showChartValueBackground: false,
                                  showChartValues: false,
                                  showChartValuesInPercentage: false,
                                  showChartValuesOutside: false,
                                  decimalPlaces: 1,
                                ),
                                legendOptions:
                                    LegendOptions(showLegends: false),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                height: 160,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Budget",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'satoshi-medium',
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "#${formatMoney(total_spent)}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'satoshi-bold',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ))
                            ],
                          )),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2,
                        height: 160,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _dataList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return PieDesc(
                                item: _dataList[index],
                              );
                            }),
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
                    child: Text(
                      "Activities",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'satoshi-bold'),
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                ]),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    height: 500,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 12,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return ActivityAdapter();
                        }),
                  ),
                ]),
              ),
            ],
          ),
        ));
  }

  Future<void> init() async {
    categoryList.add(Category(emoji: "🛒", title: "Groceries"));
    categoryList.add(Category(emoji: "🍛", title: "Food"));
    categoryList.add(Category(emoji: "⚡️", title: "Electricity"));
    categoryList.add(Category(emoji: "🌐", title: "Internet"));
    categoryList.add(Category(emoji: "⛽️", title: "Fuel"));
    categoryList.add(Category(emoji: "✈️️", title: "Transport"));
    categoryList.add(Category(emoji: "🏠️", title: "Rent"));
    categoryList.add(Category(emoji: "💰️", title: "Charity"));

    for (var i = 0; i < _dataList.length; i++) {
      total_spent += _dataList[i].total_spent;
    }

    setState(() {});

  }

  @override
  void initState() {
    init();
    super.initState();
  }
}
