import 'package:expense_management/utils/hex_color.dart';

class PieDescItem {
  int id;
  HexColor color;
  String category;
  double total_spent;

  PieDescItem({
    this.id,
    this.color,
    this.category,
    this.total_spent,
  });

}