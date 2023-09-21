import 'package:expense_management/models/budget.dart';
import 'package:expense_management/utils/db_helper.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/views/all_set.dart';
import 'package:expense_management/views/allocate_budget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewBudget extends StatefulWidget {

  @override
  State<NewBudget> createState() => _NewBudgetState();

}

class _NewBudgetState extends State<NewBudget> {

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final budgetController = TextEditingController(text: "500");
  final balanceController = TextEditingController(text: "10000");

  String currency = "";

  String _startDate = "";
  String _endDate = "";

  var db_helper = DbHelper();

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("New Budget", style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'satoshi-bold',
          fontWeight: FontWeight.w600,
        ),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: form,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text("Start Date", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: 'satoshi-medium',
                ),),
              ),
              Container(height: 5,),
              Container(
                height: 50,
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'satoshi-medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  controller: startDateController,
                  readOnly: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  onTap: () {
                    selectStartDate(context);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.grey,
                    ),
                    hintText: 'dd-mm-yyyy',
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
                child: Text("End Date", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: 'satoshi-medium',
                ),),
              ),
              Container(height: 5,),
              Container(
                height: 50,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  onTap: () {
                    selectEndDate(context);
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'satoshi-medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  readOnly: true,
                  controller: endDateController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.grey,
                    ),
                    hintText: 'dd-mm-yyyy',
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
                child: Text("Initial balance", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: 'satoshi-medium',
                ),),
              ),
              Container(height: 5,),
              Container(
                height: 50,
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'satoshi-medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  controller: balanceController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: '$currency 0.0',
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
                child: Text("Budget", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: 'satoshi-medium',
                ),),
              ),
              Container(height: 5,),
              Container(
                height: 50,
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'satoshi-medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Required";
                    }
                    else if (double.parse(balanceController.text) < double.parse(budgetController.text)) {
                      return "Cannot be greater than balance";
                    }
                    return null;
                  },
                  controller: budgetController,
                  decoration: InputDecoration(
                    hintText: '$currency 0.0',
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
              Container(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 0),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 45,
                  color: HexColor("#206CDF"),
                  onPressed: () async {
                    if (form.currentState.validate()) {
                      await saveBudget();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AllocateBudget(budget: double.parse(budgetController.text),)));
                    }
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  elevation: 5,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 10,
                      ),
                      Text(
                        "Continue",
                        style: TextStyle(
                          color: HexColor("#ffffff"),
                          fontFamily: 'satoshi-medium',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  final DateTime tomorrow = DateTime.now().add(Duration(days: 1));

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: tomorrow, // Specify the initial date
      firstDate: tomorrow, // Specify the first allowable date
      lastDate: DateTime(2101), // Specify the last allowable date
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(), // Customize the date picker theme
          child: child,
        );
      },
    );

    if (picked != null && picked != endDate) {
      // User has selected a date
      setState(() {
        endDate = picked;
        _endDate = DateFormat('dd-MM-yyyy').format(endDate);
        endDateController.text = _endDate;
      });
    }
  }

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Specify the initial date
      firstDate: DateTime.now(), // Specify the first allowable date
      lastDate: DateTime(2101), // Specify the last allowable date
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(), // Customize the date picker theme
          child: child,
        );
      },
    );

    if (picked != null && picked != startDate) {
      // User has selected a date
      setState(() {
        startDate = picked;
        _startDate = DateFormat('dd-MM-yyyy').format(startDate);
        startDateController.text = _startDate;
      });
    }
  }

  Future<void> saveBudget () async {
    var db_helper = DbHelper();
    var budget = Budget(
      id: DateTime.now().millisecondsSinceEpoch,
      initialBalance: double.parse(balanceController.text),
      startDate: startDate.millisecondsSinceEpoch,
      endDate: endDate.millisecondsSinceEpoch,
      budget: double.parse(budgetController.text),
    );
    await db_helper.saveBudget(budget);
  }

  Future<void> init () async {
    var user = await db_helper.getUser();
    currency = user.currency;
  }

  @override
  void initState () {
    super.initState();
    init();
  }

}
