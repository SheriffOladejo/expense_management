import 'package:expense_management/adapters/activity_adapter.dart';
import 'package:expense_management/adapters/category_adapter.dart';
import 'package:expense_management/adapters/pie_desc.dart';
import 'package:expense_management/models/activity.dart';
import 'package:expense_management/models/budget.dart';
import 'package:expense_management/models/category.dart';
import 'package:expense_management/models/pie_desc_item.dart';
import 'package:expense_management/models/user.dart';
import 'package:expense_management/utils/db_helper.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/utils/methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {

  Function insightCallback;
  HomePage({
    this.insightCallback,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user;

  double total_spent = 0;
  double balance;
  List<Category> categories = [];
  List<Activity> activities = [];
  List<Activity> catActivity = [];

  Category selectedCategory;

  Budget budget;
  double remaining;

  var db_helper = DbHelper();

  DateTime selectedDate = DateTime.now();
  String formattedDate;

  bool is_loading = false;

  final Map<String, double> dataMap = {};

  final List<PieDescItem> _dataList = [];

  Color spentColor = Colors.white;

  final myColorList = [
    HexColor("#7F56D9"),
    HexColor("#9AE419"),
    HexColor("#F8312F"),
    HexColor("#4287F5"),
    HexColor("#00C3C3"),
    HexColor("#FF6B6B"),
    HexColor("#4CAF50"),
    HexColor("#FFC107"),
    HexColor("#673AB7"),
    HexColor("#FF5722"),
    HexColor("#795548"),
    HexColor("#9C27B0"),
    HexColor("#2196F3"),
    HexColor("#607D8B"),
    HexColor("#E91E63"),
  ];


  List<HexColor> colorList = [];

  Future<void> catCallback (Category cat) {
    selectedCategory = cat;
    if (selectedCategory != null) {
      filterActivities();
    }
    setState(() {

    });
  }

  Category selectionCallback () {
    return selectedCategory;
  }

  Future<void> filterActivities () {
    catActivity.clear();
    for (var i = 0; i < activities.length; i++) {
      if (activities[i].category_id == selectedCategory.id) {
        catActivity.add(activities[i]);
      }
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    formattedDate = DateFormat('MMM d').format(selectedDate);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: const Text("Welcome back!",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: 'satoshi-bold',
                fontSize: 16,
              )),
        ),
        body: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: is_loading ? const Center(child: CircularProgressIndicator(),) : CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      image: DecorationImage(
                        image: AssetImage('assets/images/home-tab-bg.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Column(
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
                                GestureDetector(
                                  onTap: () {
                                    selectDate(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: HexColor("#4DFFFFFF"),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(24))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "$formattedDate",
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
                                )
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${user.currency} ${formatMoney(balance)}",
                                style: const TextStyle(
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
                                    Text(
                                      "${user.currency} ${formatMoney(budget.budget)}",
                                      style: const TextStyle(
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
                                    Text(
                                      "${user.currency} ${formatMoney(total_spent)}",
                                      style: TextStyle(
                                        color: spentColor,
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
                          ],
                        ),
                      ],
                    )),
                Container(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  child: const Text(
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
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryAdapter(category: categories[index], callback: selectionCallback, catCallback: catCallback,);
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
                                chartValuesOptions: const ChartValuesOptions(
                                  showChartValueBackground: false,
                                  showChartValues: false,
                                  showChartValuesInPercentage: false,
                                  showChartValuesOutside: false,
                                  decimalPlaces: 1,
                                ),
                                legendOptions:
                                    const LegendOptions(showLegends: false),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: 160,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Budget",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'satoshi-medium',
                                          fontSize: 9,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: user.currency,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'satoshi-medium',
                                                fontSize: 9,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            TextSpan(
                                              text: formatMoney(budget.budget),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'satoshi-bold',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
                                user: user,
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
                    child: const Text(
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
                        itemCount: selectedCategory == null ? activities.length : catActivity.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return ActivityAdapter(
                            activity: selectedCategory == null ? activities[index] : catActivity[index],
                          );
                        }),
                  ),
                ]),
              ),
            ],
          ),
        ));
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.fromMillisecondsSinceEpoch(budget.startDate),
      firstDate: DateTime.fromMillisecondsSinceEpoch(budget.startDate),
      lastDate: DateTime.fromMillisecondsSinceEpoch(budget.endDate),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('MMM d').format(selectedDate);
      });
    }
  }

  Future<void> init() async {
    setState((){
      is_loading = true;
    });

    List<Budget> budgets = await db_helper.getBudgets();
    for (var i = 0; i < budgets.length; i++) {
      if (budgets[i].endDate > DateTime.now().millisecondsSinceEpoch) {
        budget = budgets[i];
      }
    }

    user = await db_helper.getUser();

    remaining = budget.budget;
    categories = await db_helper.getCategories();
    for (var i = 0; i < categories.length; i++) {

      colorList.add(myColorList[i]);

      List<Activity> list = await db_helper.getActivityByCategory(categories[i].id);

      double total = 0;
      for (var j = 0; j < list.length; j++) {
        total += list[j].amount;
      }
      total_spent += total;
      dataMap[categories[i].title] = total;
      _dataList.add(
        PieDescItem(
            id: i, color: myColorList[i], category: categories[i].title, total_spent: total)
      );
    }

    remaining -= total_spent;
    if (remaining > 0) {
      dataMap["Remainder"] = remaining;
      colorList.add(myColorList[categories.length]);
      _dataList.add(
          PieDescItem(
              id: DateTime.now().millisecondsSinceEpoch, color: colorList[categories.length], category: "Remainder", total_spent: remaining)
      );
    }
    else if (remaining <= 0) {
      colorList.add(myColorList[categories.length]);
      _dataList.add(
          PieDescItem(
              id: DateTime.now().millisecondsSinceEpoch, color: colorList[categories.length], category: "Remainder", total_spent: 0)
      );
    }

    balance = budget.initialBalance;
    balance = balance - total_spent;



    activities = await db_helper.getActivity();

    setState((){
      is_loading = false;
    });

  }

  @override
  void initState() {
    init();
    super.initState();
  }

}
