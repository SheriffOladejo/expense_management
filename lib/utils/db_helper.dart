import 'package:expense_management/models/activity.dart';
import 'package:expense_management/models/budget.dart';
import 'package:expense_management/models/category.dart';
import 'package:expense_management/models/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:expense_management/models/candle_data.dart';
import 'package:expense_management/models/wallet.dart';
import 'package:expense_management/utils/methods.dart';
import 'package:candlesticks/candlesticks.dart';

class DbHelper {
  DbHelper._createInstance();

  String db_name = "expense_app.db";

  static Database _database;
  static DbHelper helper;

  String wallet_table = "wallet_table";
  String col_wallet_id = "id";
  String col_wallet_seed = "seed";
  String col_wallet_passphrase = "passphrase";
  String col_wallet_password = "password";
  String col_wallet_hex = "hex";

  String candle_data_table = "chart_data_table";
  String col_candle_id = "id";
  String col_candle_name = "name";
  String col_candle_fav = "favorite";
  String col_high = "high";
  String col_low = "low";
  String col_open = "open";
  String col_close = "close";
  String col_volume = "volume";
  String col_candle_date = "date";
  String col_candle_symbol = "symbol";
  String col_candle_image = "image";
  String col_candle_duration = "duration";
  String col_candle_price = "price";
  String col_candle_pct_change = "pct_change";
  String col_candle_trading_vol = "trading_vol";
  String col_candle_twentyfour_low = "twentyfour_low";
  String col_candle_twentyfour_high = "twentyfour_high";
  String col_candle_all_time_low = "all_time_low";
  String col_candle_all_time_high = "all_time_high";
  String col_candle_circulating_supply = "circulating_supply";
  String col_candle_total_supply = "total_supply";
  String col_candle_market_cap = "market_cap";
  String col_candle_market_cap_rank = "market_cap_rank";
  String col_candle_ath_date = "ath_date";
  String col_candle_atl_date = "atl_date";
  String col_candle_max_supply = "max_supply";

  String user_table = "user_table";
  String col_user_id = "id";
  String col_username = "username";
  String col_user_email = "email";
  String col_user_password = "password";
  String col_user_currency = "currency";

  String budget_table = "budget_table";
  String col_budget_id = "id";
  String col_budget_start = "startDate";
  String col_budget_end = "endDate";
  String col_budget_initial_balance = "initial_balance";
  String col_budget_budget = "budget";

  String category_table = "category_table";
  String col_cat_id = "id";
  String col_cat_title = "title";
  String col_cat_emoji = "emoji";
  String col_cat_budget = "budget";
  String col_cat_spent = "spent";

  String activity_table = "activity_table";
  String col_activity_id = "id";
  String col_activity_cat_id = "cat_id";
  String col_activity_amount = "spent";
  String col_activity_title = "title";
  String col_activity_time = "time";

  Future createDb(Database db, int version) async {

    String create_activity_table = "create table $activity_table ("
        "$col_activity_id integer primary key autoincrement,"
        "$col_activity_cat_id integer,"
        "$col_activity_amount double,"
        "$col_activity_title text,"
        "$col_activity_time integer)";

    String create_budget_table = "create table $budget_table ("
        "$col_budget_id integer,"
        "$col_budget_budget double,"
        "$col_budget_initial_balance double,"
        "$col_budget_end integer,"
        "$col_budget_start integer)";

    String create_user_table = "create table $user_table ("
        "$col_user_id text,"
        "$col_username text,"
        "$col_user_email text,"
        "$col_user_password text,"
        "$col_user_currency text)";

    String create_wallet_table = "create table $wallet_table ("
        "$col_wallet_id integer primary key autoincrement,"
        "$col_wallet_passphrase text,"
        "$col_wallet_hex text,"
        "$col_wallet_password text,"
        "$col_wallet_seed text)";

    String create_candle_table = "create table $candle_data_table ("
        "id text,"
        "high double,"
        "low double,"
        "open double,"
        "close double,"
        "volume double,"
        "symbol varchar(10),"
        "image text,"
        "name text,"
        "ath_date varchar(12),"
        "atl_date varchar(12),"
        "favorite varchar(12),"
        "max_supply double,"
        "duration varchar(10),"
        "date varchar(100),"
        "price double,"
        "pct_change double,"
        "trading_vol double,"
        "twentyfour_low double,"
        "twentyfour_high double,"
        "all_time_low double,"
        "all_time_high double,"
        "circulating_supply double,"
        "total_supply double,"
        "market_cap double,"
        "market_cap_rank integer)";

    String create_cat_table = "create table $category_table ("
        "$col_cat_id integer,"
        "$col_cat_title text,"
        "$col_cat_emoji text,"
        "$col_cat_budget double,"
        "$col_cat_spent double)";

    await db.execute(create_cat_table);
    await db.execute(create_budget_table);
    await db.execute(create_wallet_table);
    await db.execute(create_candle_table);
    await db.execute(create_user_table);
    await db.execute(create_activity_table);

  }

  factory DbHelper(){
    if(helper == null){
      helper = DbHelper._createInstance();
    }
    return helper;
  }

  Future<Database> get database async {
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    final db_path = await getDatabasesPath();
    final path = join(db_path, db_name);
    return await openDatabase(path, version: 1, onCreate: createDb);
  }

  Future<void> saveActivity (Activity activity) async {
    Database db = await database;
    String query = "insert into $activity_table ($col_activity_cat_id, $col_activity_amount, $col_activity_title, "
        "$col_activity_time) values (${activity.category_id}, ${activity.amount}, '${activity.title}', ${activity.time})";
    final params = {
      "id": activity.id.toString(),
      "category_id": activity.category_id.toString(),
      "amount": activity.amount.toStringAsFixed(1),
      "title": activity.title,
      "time": activity.time.toString(),
    };
    User user = await getUser();
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('data/users/${user.id}/activity/${activity.id.toString()}');
    try {
      await db.execute(query);
      await databaseReference.set(params);
      return true;
    }
    catch(e) {
      showToast("Activity not saved");
      return false;
    }
  }

  Future<List<Activity>> getActivity () async {
    Budget budget;
    List<Budget> budgets = await getBudgets();
    for (var i = 0; i < budgets.length; i++) {
      if (budgets[i].endDate > DateTime.now().millisecondsSinceEpoch) {
        budget = budgets[i];
      }
    }
    List<Activity> list = [];
    Database db = await database;
    String query = "select * from $activity_table where $col_activity_time > ${budget.startDate} "
        "and $col_activity_time < ${budget.endDate} order by $col_activity_time desc";
    List<Map<String, Object>> result = await db.rawQuery(query);
    for (var i = 0; i < result.length; i++) {
      list.add(
        Activity(
          id: result[i][col_activity_id],
          time: result[i][col_activity_time],
          title: result[i][col_activity_title],
          amount: result[i][col_activity_amount],
          category_id: result[i][col_activity_cat_id],
        )
      );
    }
    return list;
  }

  Future<List<Activity>> getActivityByCategory (int cat_id) async {
    List<Activity> list = [];
    Database db = await database;
    String query = "select * from $activity_table where $col_activity_cat_id = $cat_id order by $col_activity_time desc";
    List<Map<String, Object>> result = await db.rawQuery(query);
    for (var i = 0; i < result.length; i++) {
      list.add(
          Activity(
            id: result[i][col_activity_id],
            time: result[i][col_activity_time],
            title: result[i][col_activity_title],
            amount: result[i][col_activity_amount],
            category_id: result[i][col_activity_cat_id],
          )
      );
    }
    return list;
  }

  Future<void> saveCategory (Category cat) async {
    Database db = await database;
    String query = "insert into $category_table ($col_cat_id, $col_cat_title, $col_cat_emoji, "
        "$col_cat_budget, $col_cat_spent) values (${cat.id}, '${cat.title}', '${cat.emoji}', ${cat.budget}, ${cat.spent})";
    final params = {
      "id": cat.id.toString(),
      "title": cat.title,
      "emoji": cat.emoji,
      "budget": cat.budget.toString(),
      "spent": cat.spent.toString(),
    };
    User user = await getUser();
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('data/users/${user.id}/categories/${cat.id.toString()}');
    try {
      await db.execute(query);
      await databaseReference.set(params);
      return true;
    }
    catch(e) {
      showToast("Category not saved");
      return false;
    }
  }

  Future<void> getActivityFB () async {
    var user = await getUser();
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('data/users/${user.id}/activity');
    DataSnapshot snapshot = await databaseReference.get();

    if (snapshot.value != null) {
      Map<dynamic, dynamic> data = snapshot.value;

      data.forEach((key, categoryData) async {
        if (categoryData is Map) {
          double amount = double.parse(categoryData['amount']);
          int cat_id = int.parse(categoryData['category_id']);
          int id = int.parse(categoryData['id']);
          String title = categoryData['title'];
          int time = int.parse(categoryData['time']);

          await saveActivity(Activity(
            id: id,
            amount: amount,
            category_id: cat_id,
            title: title,
            time: time,
          ));

        } else {
          print("Invalid data format");
        }
      });
    } else {
      print("No data available");
    }
  }

  Future<List<Category>> getCategoriesFB() async {
    List<Category> list = [];
    var user = await getUser();
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('data/users/${user.id}/categories');
    DataSnapshot snapshot = await databaseReference.get();

    if (snapshot.value != null) {
      Map<dynamic, dynamic> data = snapshot.value;

      data.forEach((key, categoryData) {
        if (categoryData is Map) {
          double budget = double.parse(categoryData['budget']);
          double spent = double.parse(categoryData['spent']);
          int id = int.parse(categoryData['id']);
          String title = categoryData['title'];
          String emoji = categoryData['emoji'];

          list.add(
            Category(
              budget: budget,
              spent: spent,
              id: id,
              title: title,
              emoji: emoji,
            ),
          );
        } else {
          print("Invalid data format");
        }
      });
    } else {
      print("No data available");
    }

    return list;
  }

  Future<Category> getCategoryById (int id) async {
    Category cat;
    Database db = await database;
    String query = "select * from $category_table where $col_cat_id = $id";
    List<Map<String, Object>> result = await db.rawQuery(query);
    for (var i = 0; i < result.length; i++) {
      cat = Category(
        id: result[i][col_cat_id],
        emoji: result[i][col_cat_emoji],
        budget: result[i][col_cat_budget],
        title: result[i][col_cat_title],
        spent: result[i][col_cat_spent],
      );
    }
    return cat;
  }

  Future<List<Category>> getCategories () async {
    List<Category> list = [];
    Database db = await database;
    String query = "select * from $category_table";
    List<Map<String, Object>> result = await db.rawQuery(query);
    for (var i = 0; i < result.length; i++) {
      list.add(
        Category(
            id: result[i][col_cat_id],
            emoji: result[i][col_cat_emoji],
            budget: result[i][col_cat_budget],
            title: result[i][col_cat_title],
            spent: result[i][col_cat_spent],
          )
      );
    }
    return list;
  }

  Future<void> updateCategory (Category cat) async {
    User user = await getUser();
    Database db = await database;
    String query = "update $category_table set $col_cat_budget = ${cat.budget}, $col_cat_spent=${cat.spent} where "
        "$col_cat_id = ${cat.id}";
    final params = {
      "spent": cat.spent == null ? 0 :  cat.spent.toStringAsFixed(1),
      "budget": cat.budget == null ? 0 : cat.budget.toStringAsFixed(1),
    };
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('data/users/${user.id}/categories/${cat.id}');

    try {
      await db.execute(query);
      await databaseReference.update(params);
      return true;
    }
    catch(e) {
      showToast("Category not saved");
      return false;
    }
  }

  Future<void> saveBudget (Budget budget) async {
    Database db = await database;
    String query = "insert into $budget_table ($col_budget_id, $col_budget_start, $col_budget_end, $col_budget_budget, $col_budget_initial_balance) values ("
        "${budget.id}, ${budget.startDate}, ${budget.endDate}, ${budget.budget}, ${budget.initialBalance})";
    final params = {
      "id": budget.id.toString(),
      "startDate": budget.startDate.toString(),
      "endDate": budget.endDate.toString(),
      "budget": budget.budget.toString(),
      "initialBalance": budget.initialBalance.toString(),
    };
    User user = await getUser();
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('data/users/${user.id}/budgets/${budget.id.toString()}');
    try {
      await db.execute(query);
      await databaseReference.set(params);
      return true;
    }
    catch(e) {
      showToast("Budget not saved");
      return false;
    }
  }

  Future<List<Budget>> getBudgets () async {
    List<Budget> budgets = [];
    Database db = await database;
    String query = "select * from $budget_table order by $col_budget_end desc";
    List<Map<String, Object>> result = await db.rawQuery(query);
    for (var i = 0; i < result.length; i++) {
      budgets.add(
        Budget(
          id: result[i][col_budget_id],
          initialBalance: result[i][col_budget_initial_balance],
          budget: result[i][col_budget_budget],
          startDate: result[i][col_budget_start],
          endDate: result[i][col_budget_end],
        )
      );
    }
    return budgets;
  }

  Future<void> saveUser (User user) async {
    Database db = await database;
    String query = "insert into $user_table ($col_user_id, $col_username, $col_user_password, "
        "$col_user_email, $col_user_currency) values ('${user.id}', '${user.username}', '${user.password}', "
        "'${user.email}', '${user.currency}')";
    try {
      await db.execute(query);
      return true;
    }
    catch(e) {
      showToast("User not saved");
      return false;
    }
  }

  Future<User> getUser () async {
    User user;
    Database db = await database;
    String query = "select * from $user_table";
    List<Map<String, Object>> result = await db.rawQuery(query);
    for (var i = 0; i < result.length; i++) {
      user = User(
        username: result[i][col_username],
        password: result[i][col_user_password],
        currency: result[i][col_user_currency],
        email: result[i][col_user_email],
        id: result[i][col_user_id],
      );
    }
    return user;
  }

  Future<void> updateUser (User user) async {
    Database db = await database;
    String query = "update $user_table set $col_user_email = '${user.email}', $col_user_currency = '${user.currency}', "
        "$col_user_password = '${user.password}', $col_username = '${user.username}' where $col_user_id = '${user.id}'";
    final map = {
      "name": user.username,
      "email": user.email,
      "password": user.password,
      "currency": user.currency
    };
    final DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('data/users/${user.id}');
    try {
      await db.execute(query);
      await databaseReference.update(map);
      return true;
    }
    catch(e) {
      showToast("User not updated");
      return false;
    }
  }

  Future<void> clearCandleTable() async {
    Database db = await database;
    String query = "delete from $candle_data_table where $col_candle_fav != 'true'";
    await db.execute(query);
  }

  Future<void> deleteFavorite(String id) async {
    Database db = await database;
    String query = "delete from $candle_data_table where $col_candle_fav = 'true' and $col_candle_id = '$id'";
    await db.execute(query);
  }

  Future<List<CandleData>> getFavorites() async {
    List<CandleData> list = [];
    Database db = await database;
    String query = "select * from $candle_data_table where $col_candle_fav='true'";
    List<Map<String, Object>> result = await db.rawQuery(query);
    for(var i = 0; i<result.length; i++){
      Candle candle = Candle(
          open: result[i][col_open],
          close: result[i][col_close],
          high: result[i][col_high],
          low: result[i][col_low],
          volume: result[i][col_volume],
          date: DateTime.now()
      );
      CandleData data = CandleData(
        candle: candle,
        id: result[i][col_candle_id].toString(),
        candle_timestamp: result[i][col_candle_date].toString(),
        favorite: result[i][col_candle_fav].toString(),
        duration: result[i][col_candle_duration],
        symbol: result[i][col_candle_symbol],
        name: result[i][col_candle_name],
        image: result[i][col_candle_image],
        price: result[i][col_candle_price],
        pct_change: result[i][col_candle_pct_change],
        trading_vol: result[i][col_candle_trading_vol],
        twentyfour_low: result[i][col_candle_twentyfour_low],
        twentyfour_high: result[i][col_candle_twentyfour_high],
        all_time_high: result[i][col_candle_all_time_high],
        all_time_low: result[i][col_candle_all_time_low],
        circulating_supply: result[i][col_candle_circulating_supply],
        total_supply: result[i][col_candle_total_supply],
        market_cap: result[i][col_candle_market_cap],
        market_cap_rank: result[i][col_candle_market_cap_rank],
        max_supply: result[i][col_candle_max_supply],
        ath_date: result[i][col_candle_ath_date],
        atl_date: result[i][col_candle_atl_date],
      );
      list.add(data);
      //print("db_helper.getCandleData duration ${data.duration} symbol ${data.symbol}");
    }

    return list;
  }

  Future<List<CandleData>> getCandleData(String symbol, String duration) async {
    List<CandleData> list = [];
    Database db = await database;
    String query = "select * from $candle_data_table where $col_candle_symbol='$symbol' and $col_candle_duration='$duration' order by $col_candle_id ASC";
    List<Map<String, Object>> result = await db.rawQuery(query);
    for(var i = 0; i<result.length; i++){
      String date_format = "";
      if(result[i][col_candle_duration] == "1H"){
        date_format = "hh:mm aa";
      }
      else if(result[i][col_candle_duration] == "24H"){
        date_format = "hh:mm aa";
      }
      else if(result[i][col_candle_duration] == "1W"){
        date_format = "MMM dd";
      }
      else if(result[i][col_candle_duration] == "1M"){
        date_format = "MMM dd";
      }
      else if(result[i][col_candle_duration] == "6M"){
        date_format = "MMM dd";
      }
      else if(result[i][col_candle_duration] == "1Y"){
        date_format = "MMM dd YYYY";
      }

      Candle candle = Candle(
          open: result[i][col_open],
          close: result[i][col_close],
          high: result[i][col_high],
          low: result[i][col_low],
          volume: result[i][col_volume],
          date: DateTime.fromMillisecondsSinceEpoch(int.parse(result[i][col_candle_date].toString()))
      );
      CandleData data = CandleData(
        candle: candle,
        id: result[i][col_candle_id].toString(),
        candle_timestamp: result[i][col_candle_date].toString(),
        name: result[i][col_candle_name].toString(),
        duration: result[i][col_candle_duration],
        symbol: result[i][col_candle_symbol],
        image: result[i][col_candle_image],
        price: result[i][col_candle_price],
        pct_change: result[i][col_candle_pct_change],
        trading_vol: result[i][col_candle_trading_vol],
        twentyfour_low: result[i][col_candle_twentyfour_low],
        twentyfour_high: result[i][col_candle_twentyfour_high],
        all_time_high: result[i][col_candle_all_time_high],
        all_time_low: result[i][col_candle_all_time_low],
        circulating_supply: result[i][col_candle_circulating_supply],
        total_supply: result[i][col_candle_total_supply],
        market_cap: result[i][col_candle_market_cap],
        market_cap_rank: result[i][col_candle_market_cap_rank],
        max_supply: result[i][col_candle_max_supply],
        ath_date: result[i][col_candle_ath_date],
        atl_date: result[i][col_candle_atl_date],
        favorite: result[i][col_candle_fav],
      );
      list.add(data);
      //print("db_helper.getCandleData duration ${data.duration} symbol ${data.symbol}");
    }

    return list;
  }

  Future<void> saveCandleData(CandleData candle) async {
    Database db = await database;
    String query = "insert into $candle_data_table ("
        "$col_candle_id, $col_candle_name, $col_open, $col_close, $col_high, $col_low, $col_candle_date, $col_volume, $col_candle_symbol, $col_candle_duration, "
        "$col_candle_price, $col_candle_pct_change, $col_candle_trading_vol, $col_candle_twentyfour_low, "
        "$col_candle_twentyfour_high, $col_candle_all_time_low, $col_candle_all_time_high, "
        "$col_candle_circulating_supply, $col_candle_total_supply, $col_candle_market_cap, $col_candle_market_cap_rank, $col_candle_image, "
        "$col_candle_ath_date, $col_candle_atl_date, $col_candle_max_supply, $col_candle_fav) "
        "values ('${candle.id}', '${candle.name}',  ${candle.candle.open}, ${candle.candle.close}, ${candle.candle.high}, ${candle.candle.low}, "
        "'${candle.candle_timestamp.toString()}', ${candle.candle.volume}, '${candle.symbol}', '${candle.duration}', "
        "${candle.price}, ${candle.pct_change}, ${candle.trading_vol}, ${candle.twentyfour_low}, ${candle.twentyfour_high}, "
        "${candle.all_time_low}, ${candle.all_time_high}, ${candle.circulating_supply}, ${candle.total_supply}, "
        "${candle.market_cap}, ${candle.market_cap_rank}, '${candle.image}', '${candle.ath_date}', "
        "'${candle.atl_date}', ${candle.max_supply}, '${candle.favorite}')";
    await db.execute(query);
  }

  Future<bool> saveWallet(Wallet wallet) async {
    Database db = await database;
    String query = "insert into $wallet_table ($col_wallet_hex, $col_wallet_password, "
        "$col_wallet_seed, $col_wallet_passphrase) values ('${wallet.hex}', '${wallet.password}', "
        "'${wallet.seed}', '${wallet.passphrase}')";
    try {
      await db.execute(query);
      return true;
    }
    catch(e) {
      print("db_helper.saveWallet error: ${e.toString()}");
      showToast("Wallet not saved");
      return false;
    }
  }

  Future<bool> deleteWallet(Wallet wallet) async {
    Database db = await database;
    String query = "delete from $wallet_table where $col_wallet_id = ${wallet.id}";
    try {
      await db.execute(query);
      return true;
    }
    catch(e) {
      print("db_helper.deleteWallet error: ${e.toString()}");
      showToast("Wallet not deleted");
      return false;
    }
  }

  Future<List<Wallet>> getWallets() async {
    List<Wallet> wallets = [];
    Database db = await database;
    String query = "select * from $wallet_table";
    List<Map<String, Object>> result = await db.rawQuery(query);
    for (int i = 0; i < result.length; i++) {
      Wallet w = Wallet(
        id: int.parse(result[i][col_wallet_id].toString()),
        seed: result[i][col_wallet_seed].toString(),
        password: result[i][col_wallet_password].toString(),
        hex: result[i][col_wallet_hex].toString(),
        passphrase: result[i][col_wallet_passphrase].toString(),
      );
      wallets.add(w);
    }
    return wallets;
  }

}