import 'package:expense_management/adapters/activity_adapter.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:flutter/material.dart';

class Reports extends StatefulWidget {

  @override
  State<Reports> createState() => _ReportsState();

}

class _ReportsState extends State<Reports> {

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: Column(
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
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
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
                  itemCount: 11,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return ActivityAdapter();
                  }),
            ),
          ],
        ),
      ),
    );
  }

}
