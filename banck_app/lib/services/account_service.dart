import 'package:supabase_flutter/supabase_flutter.dart';

/// Account model
class Account {
  final int id;
  final String userId;
  final int? accountNumber;
  final DateTime createdAt;

  Account({
    required this.id,
    required this.userId,
    this.accountNumber,
    required this.createdAt,
  });

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'] as int,
      userId: map['user'] as String,
      accountNumber: map['account_number'] != null
          ? map['account_number'] as int
          : null,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}

/// Account constants
class AccountConstants {
  static const double initialBalance = 10000.0;
  static const double minimumBalance = 500.0;
  static const String currency = 'Rs';
}

/// Account service for managing user accounts and balance
class AccountService {
  static final _supabase = Supabase.instance.client;

  /// Get current user's account
  static Future<Account?> getAccount() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    try {
      final data = await _supabase
          .from('account')
          .select()
          .eq('"user"', user.id)
          .single();

      return Account.fromMap(data);
    } catch (e) {
      return null;
    }
  }

  /// Get current balance (sum of credits - debits)
  static Future<double> getBalance() async {
    final account = await getAccount();
    if (account == null) return 0.0;

    try {
      final data = await _supabase
          .from('transactions')
          .select('amount')
          .eq('account', account.id);

      double balance = 0.0;
      for (final item in data) {
        final type = item['type'] as String;
        final amount = (item['amount'] as num).toDouble();
        if (type == 'credit') {
          balance += amount;
        } else if (type == 'debit') {
          balance -= amount;
        }
      }
      return balance;
    } catch (e) {
      return 0.0;
    }
  }

  /// Get current balance (redeemable amount)
  static Future<double> getRedeemableBalance() async {
    final balance = await getBalance();
    return balance - AccountConstants.minimumBalance;
  }

  /// Format balance for display
  static String formatBalance(
    double balance, {
    String currency = AccountConstants.currency,
  }) {
    return '$currency ${balance.toStringAsFixed(2)}';
  }

  /// Get minimum balance (non-redeemable)
  static double getMinimumBalance() {
    return AccountConstants.minimumBalance;
  }

  /// Get maximum redeemable amount
  static double getMaximumRedeemable() {
    return AccountConstants.initialBalance - AccountConstants.minimumBalance;
  }

  /// Check if amount is within redeemable limits
  static bool canRedeem(double amount) {
    return amount <= getMaximumRedeemable() && amount > 0;
  }

  /// Validate if withdrawal is allowed
  static String? validateWithdrawal(double amount) {
    if (amount <= 0) {
      return 'Amount must be greater than 0';
    }
    if (amount > getMaximumRedeemable()) {
      return 'Maximum redeemable amount is ${formatBalance(getMaximumRedeemable())}';
    }
    return null;
  }

  /// Check if account exists
  static Future<bool> accountExists() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    try {
      final data = await _supabase
          .from('account')
          .select('id')
          .eq('"user"', user.id)
          .single();

      return data != null;
    } catch (e) {
      return false;
    }
  }

  /// Create account for new user
  static Future<bool> createAccount({int? accountNumber}) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    try {
      await _supabase.from('account').insert({
        'user': user.id,
        'account_number': accountNumber,
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Ensure account exists, create if not
  static Future<void> ensureAccountExists() async {
    final exists = await accountExists();
    if (!exists) {
      await createAccount();
    }
  }

  /// Get account summary
  static Future<Map<String, double>> getAccountSummary() async {
    final balance = await getBalance();
    return {
      'total': balance,
      'redeemable': balance - AccountConstants.minimumBalance,
      'minimum': AccountConstants.minimumBalance,
    };
  }
}
