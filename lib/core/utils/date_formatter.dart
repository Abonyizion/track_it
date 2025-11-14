import 'package:intl/intl.dart';

class DateFormatter {
  /// Formats a DateTime to a readable string, e.g. "Nov 10, 2025"
  static String formatDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  /// Optional: Format with time, e.g. "Nov 10, 2025 14:30"
  static String formatDateTime(DateTime date) {
    return DateFormat('y MMM d  HH:mm').format(date);
  }

  /// Formats a number as currency with symbol, e.g. "₦1,234.56" or "$1,234.56"
  static String formatCurrency(double amount, {String symbol = '\$', String locale = 'en_US'}) {
    return '$symbol${NumberFormat('#,##0.00', locale).format(amount)}';
  }
}
