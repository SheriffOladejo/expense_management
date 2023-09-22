import 'package:expense_management/models/category.dart';
import 'package:expense_management/models/user.dart';
import 'package:expense_management/utils/db_helper.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/utils/methods.dart';
import 'package:expense_management/utils/uppercase_input_formatter.dart';
import 'package:expense_management/views/login.dart';
import 'package:expense_management/views/select_currency.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {

  @override
  State<CreateAccount> createState() => _CreateAccountState();

}

class _CreateAccountState extends State<CreateAccount> {

  final form = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController(text: "Sheriff");
  final TextEditingController emailController = TextEditingController(text: "sherifffoladejo@gmail.com");
  final TextEditingController passwordController = TextEditingController(text: "password");
  final TextEditingController confirmController = TextEditingController(text: "pass");

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Image.asset("assets/images/_icon.png", width: 50, height: 50,),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Form(
        key: form,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          child: isLoading ? Center(
            child: CircularProgressIndicator(),
          ) : SingleChildScrollView(
            child: Column(
              children: [
                Text("Create an account", style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'satoshi-medium',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),),
                Container(height: 25,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text("Name", style: TextStyle(
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      }
                      else {
                        return null;
                      }
                    },
                    controller: nameController,
                    textCapitalization: TextCapitalization.sentences,
                    inputFormatters: [
                      UppercaseInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      //contentPadding: EdgeInsets.all(15.0),
                      hintText: 'Enter your name',
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
                Container(height: 5,),
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      }
                      else if (!isEmailValid(value)) {
                        return "Invalid email";
                      }
                      else {
                        return null;
                      }
                    },
                    controller: emailController,
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
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'satoshi-medium',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      }
                      else if (value.length < 8) {
                        return "Invalid password";
                      }
                      else {
                        return null;
                      }
                    },
                    controller: passwordController,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      //contentPadding: EdgeInsets.all(15.0),
                      hintText: 'Create a password',
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
                Container(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text("Must be at least 8 characters", style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    fontFamily: 'satoshi-medium',
                  ),),
                ),
                Container(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text("Confirm Password", style: TextStyle(
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
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'satoshi-medium',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      }
                      else if (value != passwordController.text) {
                        return "Passwords don't match";
                      }
                      else {
                        return null;
                      }
                    },
                    controller: confirmController,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      //contentPadding: EdgeInsets.all(15.0),
                      hintText: 'Repeat password',
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
                        await signUp();
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
                          "Get Started",
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
                //Container(height: 10,),
                // Padding(
                //   padding: const EdgeInsets.only(left: 0, right: 0),
                //   child: MaterialButton(
                //     minWidth: MediaQuery.of(context).size.width,
                //     height: 45,
                //     color: HexColor("#ffffff"),
                //     onPressed: () {
                //       Navigator.push(context, MaterialPageRoute(builder: (context) => SelectCurrency()));
                //     },
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(3)),
                //         side: BorderSide(
                //           color: HexColor("#206CDF"),
                //           width: 1.0,
                //         ),
                //     ),
                //     elevation: 5,
                //     child: Row(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Container(width: 10,),
                //         Image.asset("assets/images/google.png", width: 24, height: 24,),
                //         Container(width: 10,),
                //         const Text("Sign up with Google", style: TextStyle(
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
                Container(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Already have an account?", style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: 'satoshi-medium',
                    ),),
                    Container(width: 3,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text("Log in", style: TextStyle(
                        color: HexColor("#206CDF"),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: 'satoshi-medium',
                      ),),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp () async {
    setState(() {
      isLoading = true;
    });
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    final data = {
      "name": nameController.text.trim().toString(),
      "email": emailController.text.trim().toString(),
      "id": id,
      "password": passwordController.text.toString(),
    };

    final DatabaseReference databaseReference =
    FirebaseDatabase.instance.ref().child('data/users/$id');

    var user = User(
      id: id,
      username: nameController.text.trim().toString(),
      email: emailController.text.trim().toString(),
      password: passwordController.text.toString(),
    );

    var db_helper = DbHelper();

    await db_helper.saveUser(user);

    databaseReference.set(data).then((_) async {

      await db_helper.saveCategory(Category(id: 1695394012926, emoji: "🛒", title: "Groceries", budget: 0, spent: 0));
      await db_helper.saveCategory(Category(id: 1695394012925, emoji: "🍛", title: "Food", budget: 0, spent: 0));
      await db_helper.saveCategory(Category(id: 1695394012924, emoji: "⚡️", title: "Electricity", budget: 0, spent: 0));
      await db_helper.saveCategory(Category(id: 1695394012923, emoji: "🌐", title: "Internet", budget: 0, spent: 0));
      await db_helper.saveCategory(Category(id: 1695394012922, emoji: "⛽️", title: "Fuel", budget: 0, spent: 0));
      await db_helper.saveCategory(Category(id: 1695394012921, emoji: "✈️️", title: "Transport", budget: 0, spent: 0));
      await db_helper.saveCategory(Category(id: 1695394012920, emoji: "🏠️", title: "Rent", budget: 0, spent: 0));
      await db_helper.saveCategory(Category(id: 1695394012919, emoji: "💰️", title: "Charity", budget: 0, spent: 0));

      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    }).catchError((error) {
      print("sign up error: ${error.toString()}");
      showToast("Unable to sign up, try again");
    });


    setState(() {
      isLoading = false;
    });
  }

}
