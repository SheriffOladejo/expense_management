import 'package:expense_management/adapters/activity_adapter.dart';
import 'package:expense_management/models/activity.dart';
import 'package:expense_management/models/budget.dart';
import 'package:expense_management/models/category.dart';
import 'package:expense_management/utils/db_helper.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:flutter/material.dart';

class Reports extends StatefulWidget {

  @override
  State<Reports> createState() => _ReportsState();

}

class _ReportsState extends State<Reports> {

  final searchController = TextEditingController();

  List<Activity> activities;
  List<Activity> searchList = [];
  var db_helper = DbHelper();

  Budget budget;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Reports", style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'satoshi-bold',
          fontWeight: FontWeight.w600,
        ),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          child: isLoading ? Center(child: CircularProgressIndicator(),) : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 10,),
              Container(
                height: 50,
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'satoshi-medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  onChanged: (value) async {
                    await search(value);
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        searchController.text = "";
                        setState(() {

                        });
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'satoshi-medium',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(color: HexColor("#D0D5DD")),
                    ),
                  ),
                ),
              ),
              Container(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text("Activities", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: 'satoshi-medium',
                ),),
              ),
              Container(height: 10,),
              Container(
                height: MediaQuery.of(context).size.height - 270,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchList.isNotEmpty ? searchList.length : activities.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ActivityAdapter(
                        activity: searchList.isNotEmpty ? searchList[index] : activities[index],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> search (String word) async {
    searchList.clear();
    for (var i = 0; i < activities.length; i++) {
      if (activities[i].title.contains(word)) {
        searchList.add(activities[i]);
      }
    }
    setState(() {

    });
  }

  Future<void> init () async {
    setState(() {
      isLoading = true;
    });
    List<Budget> budgets = await db_helper.getBudgets();
    for (var i = 0; i < budgets.length; i++) {
      if (budgets[i].endDate > DateTime.now().millisecondsSinceEpoch) {
        budget = budgets[i];
      }
    }
    activities = await db_helper.getActivity();
    activities.removeWhere((element) {
      if (element.time > budget.startDate && element.time < budget.endDate) {
        return false;
      }
      return true;
    });
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
