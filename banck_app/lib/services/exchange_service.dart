import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Currency model
class Currency {
  final String code;
  final String symbol;
  final String name;
  final double rate;

  const Currency({
    required this.code,
    required this.symbol,
    required this.name,
    required this.rate,
  });

  static const List<Currency> supportedCurrencies = [
    Currency(code: 'USD', symbol: '\$', name: 'US Dollar', rate: 1.0),
    Currency(code: 'EUR', symbol: '€', name: 'Euro', rate: 0.92),
    Currency(code: 'GBP', symbol: '£', name: 'British Pound', rate: 0.78),
    Currency(code: 'INR', symbol: '₹', name: 'Indian Rupee', rate: 83.50),
    Currency(code: 'JPY', symbol: '¥', name: 'Japanese Yen', rate: 149.50),
    Currency(code: 'CAD', symbol: 'C\$', name: 'Canadian Dollar', rate: 1.35),
    Currency(code: 'AUD', symbol: 'A\$', name: 'Australian Dollar', rate: 1.53),
  ];

  static Currency getByCode(String code) {
    return supportedCurrencies.firstWhere(
      (c) => c.code == code,
      orElse: () => supportedCurrencies[0],
    );
  }

  double convertTo(double amount, Currency to) {
    // First convert to USD (base), then to target
    final usdAmount = amount / rate;
    return usdAmount * to.rate;
  }

  String format(double amount) {
    return '$symbol${amount.toStringAsFixed(2)}';
  }
}

/// Exchange service for currency conversion
class ExchangeService {
  static final _supabase = Supabase.instance.client;

  /// Exchange rates (in real app, fetch from API)
  static const Map<String, double> rates = {
    'USD': 1.0,
    'EUR': 0.92,
    'GBP': 0.78,
    'INR': 83.50,
    'JPY': 149.50,
    'CAD': 1.35,
    'AUD': 1.53,
  };

  /// Convert amount between currencies
  static double convert(double amount, String fromCurrency, String toCurrency) {
    final fromRate = rates[fromCurrency] ?? 1.0;
    final toRate = rates[toCurrency] ?? 1.0;

    // Convert to base (USD), then to target
    final baseAmount = amount / fromRate;
    return baseAmount * toRate;
  }

  /// Format converted amount
  static String formatAmount(double amount, String currency) {
    final curr = Currency.getByCode(currency);
    return curr.format(amount);
  }

  /// Get available currencies
  static List<Currency> getAvailableCurrencies() {
    return Currency.supportedCurrencies;
  }

  /// Record an exchange transaction
  static Future<bool> recordExchange({
    required double amount,
    required String fromCurrency,
    required String toCurrency,
    required double convertedAmount,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    try {
      await _supabase.from('transactions').insert({
        'user_id': user.id,
        'type': 'debit',
        'amount': amount,
        'description':
            'Exchange $amount $fromCurrency to $convertedAmount $toCurrency',
      });

      await _supabase.from('transactions').insert({
        'user_id': user.id,
        'type': 'credit',
        'amount': convertedAmount,
        'description': 'Exchange received: $convertedAmount $toCurrency',
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get exchange rate between two currencies
  static double getRate(String fromCurrency, String toCurrency) {
    final fromRate = rates[fromCurrency] ?? 1.0;
    final toRate = rates[toCurrency] ?? 1.0;
    return toRate / fromRate;
  }

  /// Calculate exchange fee (1% of amount)
  static double calculateFee(double amount) {
    return amount * 0.01;
  }

  /// Get minimum exchange amount
  static double getMinimumAmount(String currency) {
    return 10.0; // $10 minimum
  }

  /// Get maximum exchange amount
  static double getMaximumAmount(String currency) {
    return 10000.0; // $10,000 maximum
  }

  /// Validate exchange amount
  static String? validateAmount(double amount, String currency) {
    final minAmount = getMinimumAmount(currency);
    final maxAmount = getMaximumAmount(currency);

    if (amount < minAmount) {
      return 'Minimum exchange amount is ${Currency.getByCode(currency).format(minAmount)}';
    }
    if (amount > maxAmount) {
      return 'Maximum exchange amount is ${Currency.getByCode(currency).format(maxAmount)}';
    }
    return null;
  }
}
