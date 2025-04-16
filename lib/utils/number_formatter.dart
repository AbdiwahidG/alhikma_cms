import 'package:intl/intl.dart';

class NumberFormatter {
  static final currencyFormat = NumberFormat.currency(symbol: 'KES ', decimalDigits: 0);
  static final percentFormat = NumberFormat.percentPattern();
  
  static String formatCurrency(double amount) {
    return currencyFormat.format(amount);
  }
  
  static String formatPercentage(double value) {
    return percentFormat.format(value / 100);
  }
  
  static String formatCompactCurrency(double amount) {
    if (amount >= 1000000000) {
      return 'KES ${(amount / 1000000000).toStringAsFixed(1)}B';
    } else if (amount >= 1000000) {
      return 'KES ${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return 'KES ${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return 'KES ${amount.toStringAsFixed(0)}';
    }
  }
} 