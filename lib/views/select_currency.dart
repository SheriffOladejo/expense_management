import 'package:expense_management/models/currency.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/views/new_budget.dart';
import 'package:flutter/material.dart';

class SelectCurrency extends StatefulWidget {

  @override
  State<SelectCurrency> createState() => _SelectCurrencyState();

}

class _SelectCurrencyState extends State<SelectCurrency> {

  List<Currency> currencies = [];

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
            Text("Select base currency", style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'satoshi-medium',
              fontWeight: FontWeight.w600,
            ),),
            Container(height: 35,),
            Image.asset("assets/images/amico.png",),
            Container(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              child: DropdownButtonHideUnderline(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: DropdownButton<String>(
                    hint: Text("Select a currency", style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'satoshi-medium',
                      fontWeight: FontWeight.w600,
                    ),),
                    value: null,
                    onChanged: (String newValue) {

                    },
                    items: currencies.map<DropdownMenuItem<String>>((Currency currency) {
                      return DropdownMenuItem<String>(
                        value: currency.cc,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          child: Text('${currency.name} - ${currency.symbol}')
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Container(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                height: 45,
                color: HexColor("#206CDF"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewBudget()));
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
            Text("Your base currency should be the one you use most often. Your balance and stats will be shown in this currency",
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

  Future<void> init () async {
    fetchCurrencies().then((currencies) {
      setState(() {
        this.currencies = currencies;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

}

class SelectCurrencyDialog extends StatefulWidget {

  @override
  State<SelectCurrencyDialog> createState() => _SelectCurrencyDialogState();

}

class _SelectCurrencyDialogState extends State<SelectCurrencyDialog> {

  String selectedCurrency = 'USD';

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
      title: Text('Choose your currency'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: currencies.length,
            itemBuilder: (context, index) {
              final currency = currencies[index];
              final currencyCode = currency['code'];
              final currencyName = currency['name'];

              return ListTile(
                title: Text('$currencyCode - $currencyName'),
                leading: Radio<String>(
                  value: currencyCode,
                  groupValue: selectedCurrency,
                  onChanged: (value) {
                    setState(() {
                      selectedCurrency = value;
                    });
                  },
                ),
              );
            },
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle the selected currency (selectedCurrency)
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

