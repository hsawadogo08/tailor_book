import 'package:intl/intl.dart';

class AmountFormater {
  // Format an amount
  // [amount] is the amount to format
  static String format(int amount) {
    var formatter = NumberFormat("#,###.##");
    return formatter.format(amount).replaceAll(",", " ");
  }
}
