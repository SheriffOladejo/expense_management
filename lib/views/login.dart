import 'package:expense_management/models/budget.dart';
import 'package:expense_management/models/category.dart';
import 'package:expense_management/models/user.dart';
import 'package:expense_management/utils/db_helper.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/utils/methods.dart';
import 'package:expense_management/views/allocate_budget.dart';
import 'package:expense_management/views/create_account.dart';
import 'package:expense_management/views/expense_bottom_nav.dart';
import 'package:expense_management/views/new_budget.dart';
import 'package:expense_management/views/select_currency.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {

  @override
  State<Login> createState() => _LoginState();

}

class _LoginState extends State<Login> {

  final form = GlobalKey<FormState>();

  final emailController = TextEditingController(text: "sherifffoladejo@gmail.com");
  final passwordController = TextEditingController(text: "password");

  bool isLoading = false;

  var dbHelper = DbHelper();

  bool showPassword = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Image.asset("assets/images/_icon.png", width: 50, height: 50,),
        centerTitle: true,
      ),
      body: Form(
        key: form,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          child: isLoading ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
            child: Column(
              children: [
                Text("Login to account", style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'satoshi-medium',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),),
                Container(height: 25,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text("Email", style: TextStyle(
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
                    controller: emailController,
                    validator: (val) {
                      if (!isEmailValid(val)) {
                        return "Invalid email";
                      }
                      else if (val.isEmpty) {
                        return "Required";
                      }
                      else {
                        return null;
                      }
                    },
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      //contentPadding: EdgeInsets.all(15.0),
                      hintText: 'Enter your email',
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
                  child: Text("Password", style: TextStyle(
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
                    controller: passwordController,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Required";
                      }
                      else {
                        return null;
                      }
                    },
                    obscureText: !showPassword,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      //contentPadding: EdgeInsets.all(15.0),
                      hintText: 'Enter password',
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
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: Icon(
                          showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
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
                        await login();
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
                          "Login",
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
                // Padding(
                //   padding: const EdgeInsets.only(left: 0, right: 0),
                //   child: MaterialButton(
                //     minWidth: MediaQuery.of(context).size.width,
                //     height: 45,
                //     color: HexColor("#ffffff"),
                //     onPressed: () {
                //
                //     },
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(3)),
                //       side: BorderSide(
                //         color: HexColor("#206CDF"),
                //         width: 1.0,
                //       ),
                //     ),
                //     elevation: 5,
                //     child: Row(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Container(width: 10,),
                //         Image.asset("assets/images/google.png", width: 24, height: 24,),
                //         Container(width: 10,),
                //         const Text("Login with Google", style: TextStyle(
                //           color: Colors.black,
                //           fontFamily: 'inter-medium',
                //           fontSize: 16,
                //           fontWeight: FontWeight.w500,
                //         ),),
                //         Container(width: 10,),
                //       ],
                //     ),
                //   ),
                // ),
                Container(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Don't have an account?", style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: 'satoshi-medium',
                    ),),
                    Container(width: 3,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CreateAccount()));
                      },
                      child: Text("Sign Up", style: TextStyle(
                        color: HexColor("#206CDF"),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: 'satoshi-medium',
                      ),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login () async {
    setState(() {
      isLoading = true;
    });
    User user;
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('data/users');
    DataSnapshot snapshot = await databaseReference.get();
    Map<dynamic, dynamic> values = snapshot.value;
    bool accountFound = false;
    bool correctCredentials = false;

    Budget budget;

    if (values != null) {
      values.forEach((key, value) async {
        if (value is Map && value.containsKey('email')) {
          String email = value['email'];
          String password = value['password'];

          if (email.toLowerCase() == emailController.text.toString().toLowerCase()) {
            accountFound = true;
            if (password != passwordController.text) {
              showToast("Incorrect password");
              setState(() {
                isLoading = false;
              });
            }
            else if (passwordController.text == password) {
              correctCredentials = true;
              String currency = value['currency'];
              String id = value['id'];
              String name = value['name'];

              user = User(
                username: name,
                id: id,
                currency: currency,
                email: email,
                password: password,
              );
              await dbHelper.saveUser(user);
            }
          }
        }
      });
    }

    if (user != null) {
      databaseReference = FirebaseDatabase.instance.ref().child('data/users/${user.id}/budgets');
      DataSnapshot snapshot = await databaseReference.get();
      Map<dynamic, dynamic> values = snapshot.value;
      if (values != null) {
        values.forEach((key, value) async {
          if (value is Map && value.containsKey('budget')) {
            double _budget = double.parse(value['budget']);
            int startDate = int.parse(value['startDate'].toString());
            int endDate = int.parse(value['endDate'].toString());
            int id = int.parse(value['id'].toString());
            double balance = double.parse(value['initialBalance'].toString());
            if (endDate > DateTime.now().millisecondsSinceEpoch) {
              budget = Budget(
                id: id,
                initialBalance: balance,
                startDate: startDate,
                endDate: endDate,
                budget: _budget,
              );
              await dbHelper.saveBudget(budget);
            }
          }
        });
      }

      await dbHelper.saveUser(user);

      if (user.currency == '' || user.currency == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SelectCurrency()));
      }
      else if (budget == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewBudget()));
      }
      else if (budget != null) {
        List<Category> list = await dbHelper.getCategoriesFB();
        double totalBudget = 0;
        for (var i = 0; i < list.length; i++) {
          totalBudget += list[i].budget;
        }
        if (totalBudget == 0) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AllocateBudget(budget: budget.budget,)));
        }
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ExpenseBottomNav()));
      }
    }
    print(accountFound);

    if (!accountFound) {
      showToast("Account not found");
    }

    setState(() {
      isLoading = false;
    });
  }

}
