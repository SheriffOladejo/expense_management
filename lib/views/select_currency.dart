import 'package:expense_management/models/currency.dart';
import 'package:expense_management/utils/db_helper.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/utils/methods.dart';
import 'package:expense_management/views/new_budget.dart';
import 'package:flutter/material.dart';

class SelectCurrency extends StatefulWidget {

  @override
  State<SelectCurrency> createState() => _SelectCurrencyState();

}

class _SelectCurrencyState extends State<SelectCurrency> {

  List<Currency> currencies = [];

  String selected_currency = "";

  String text = "";

  var db_helper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Select base currency", style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'satoshi-medium',
              fontWeight: FontWeight.w600,
            ),),
            Container(height: 35,),
            Image.asset("assets/images/amico.png",),
            Container(height: 15,),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SelectCurrencyDialog(callback: callback,);
                  },
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                ),
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(selected_currency == "" ? "Select a currency" : text, style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'satoshi-medium',
                      fontWeight: FontWeight.w600,
                    ),),
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down),
                  ],
                )
              ),
            ),
            Container(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                height: 45,
                color: HexColor("#206CDF"),
                onPressed: () async {
                  if (selected_currency == "") {
                    showToast("Select a currency");
                  }
                  else {
                    showToast("Creating currency please wait");
                    var user = await db_helper.getUser();
                    user.currency = selected_currency;
                    await db_helper.updateUser(user);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewBudget()));
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
                      "Create your budget",
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
            Container(height: 20,),
            const Text("Your base currency should be the one you use most often. Your balance and stats will be shown in this currency",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontFamily: 'satoshi-medium',
              fontSize: 12,
            ),
            textAlign: TextAlign.center,),
            Container(height: 10,)
          ],
        ),
      ),
    );
  }

  Future<void> callback (currencyCode, String name) async {
    setState(() {
      selected_currency = currencyCode;
    });

    text = selected_currency + " - " + name;
  }

  Future<void> init () async {

  }

  @override
  void initState() {
    super.initState();
    init();
  }

}

class SelectCurrencyDialog extends StatefulWidget {

  String selectedCurrency = 'USD';
  String name = "";
  Function callback;

  SelectCurrencyDialog({
    this.callback
  });

  @override
  State<SelectCurrencyDialog> createState() => _SelectCurrencyDialogState();

}

class _SelectCurrencyDialogState extends State<SelectCurrencyDialog> {

  List<Map<String, String>> currencies = [
    {'code': 'USD', 'name': 'United States Dollars'},
    {'code': 'AUD', 'name': 'Australian Dollars'},
    {'code': 'CAD', 'name': 'Canadian Dollars'},
    {'code': 'HKD', 'name': 'Hong Kong Dollars'},
    {'code': 'GBP', 'name': 'British Pound Sterling'},
    {'code': 'NGN', 'name': 'Nigerian Naira'},
    {'code': 'EUR', 'name': 'Euro'},
    {'code': 'JPY', 'name': 'Japanese Yen'},
    {'code': 'INR', 'name': 'Indian Rupee'},
    {'code': 'AED', 'name': 'United Arab Emirate Dirham'},
    {'code': 'ZAR', 'name': 'South African Rand'},
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose your currency'),
      content: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(),
            Container(
              height: MediaQuery.of(context).size.height - 260,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: currencies.length,
                itemBuilder: (context, index) {
                  final currency = currencies[index];
                  final currencyCode = currency['code'];
                  final currencyName = currency['name'];

                  return ListTile(
                    title: Text('$currencyCode - $currencyName', style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'inter-regular',
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),),
                    leading: Radio<String>(
                      value: currencyCode,
                      groupValue: widget.selectedCurrency,
                      onChanged: (value) {
                        setState(() {
                          widget.selectedCurrency = value;
                          widget.name = currencies[index]["name"];
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    widget.callback(widget.selectedCurrency, widget.name);
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



}

