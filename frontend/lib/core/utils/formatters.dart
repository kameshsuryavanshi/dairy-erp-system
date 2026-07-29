import 'package:intl/intl.dart';

class Formatters {
  static String currency(double amount) {
    final formatter = NumberFormat.currency(symbol: '₹', decimalDigits: 2, locale: 'en_IN');
    return formatter.format(amount);
  }

  static String quantity(double liters) {
    return '${liters.toStringAsFixed(2)} L';
  }

  static String percentage(double percent) {
    return '${percent.toStringAsFixed(1)}%';
  }

  static String formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }
}
