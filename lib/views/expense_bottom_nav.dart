import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/views/expense_settings_screen.dart';
import 'package:expense_management/views/home_page.dart';
import 'package:expense_management/views/reports.dart';
import 'package:expense_management/views/select_category.dart';
import 'package:expense_management/views/statistics.dart';
import 'package:expense_management/views/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ExpenseBottomNav extends StatefulWidget {

  @override
  State<ExpenseBottomNav> createState() => _ExpenseBottomNavState();

}

class _ExpenseBottomNavState extends State<ExpenseBottomNav> {

  PersistentTabController _controller;

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      Statistics(),
      SelectCategory(),
      Reports(),
      const ExpenseSettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: HexColor("#ffffff"),
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property.
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.0 : kBottomNavigationBarHeight,
      ),
    );
  }

  Future<void> callback() async {
    setState(() {

    });
  }

  Future<void> init () async {
    _controller = PersistentTabController(initialIndex: 0);
    setState(() {

    });
  }

  @override
  void initState () {
    super.initState();
    init();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        textStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'inter-medium',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        icon: ImageIcon(
          AssetImage("assets/images/wallet.png"),
        ),
        activeColorPrimary: HexColor("#194D9B"),
        inactiveColorPrimary: HexColor("#AAAAAA"),
      ),
      PersistentBottomNavBarItem(
        textStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'inter-medium',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        icon: ImageIcon(
          AssetImage("assets/images/market.png"),
        ),
        activeColorPrimary: HexColor("#194D9B"),
        inactiveColorPrimary: HexColor("#AAAAAA"),
      ),
      PersistentBottomNavBarItem(
        textStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'inter-medium',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        icon: Icon(Icons.add, color: Colors.white,),
        activeColorPrimary: HexColor("#194D9B"),
        inactiveColorPrimary: HexColor("#AAAAAA"),
      ),
      PersistentBottomNavBarItem(
        textStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'inter-medium',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        icon: ImageIcon(
          AssetImage("assets/images/explore.png"),
        ),
        activeColorPrimary: HexColor("#194D9B"),
        inactiveColorPrimary: HexColor("#AAAAAA"),
      ),
      PersistentBottomNavBarItem(
        textStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'inter-medium',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        icon: ImageIcon(
          AssetImage("assets/images/settings.png"),
        ),
        activeColorPrimary: HexColor("#194D9B"),
        inactiveColorPrimary: HexColor("#AAAAAA"),
      ),
    ];
  }

}
