import 'package:supabase_flutter/supabase_flutter.dart';

/// Transaction model
class Transaction {
  final String id;
  final String userId;
  final String type;
  final double amount;
  final String description;
  final DateTime createdAt;
  final int? accountId;

  Transaction({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.description,
    required this.createdAt,
    this.accountId,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as String,
      userId: map['user'] as String,
      type: map['type'] as String,
      amount: (map['amount'] as num).toDouble(),
      description: map['description'] as String? ?? '',
      createdAt: DateTime.parse(map['created_at'] as String),
      accountId: map['account'] != null ? map['account'] as int : null,
    );
  }
}

/// Transaction service for managing financial transactions
class TransactionService {
  static final _supabase = Supabase.instance.client;

  /// Get all transactions for current user
  static Future<List<Transaction>> getTransactions({int limit = 50}) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    try {
      final data = await _supabase
          .from('transactions')
          .select()
          .eq('"user"', user.id)
          .order('created_at', ascending: false)
          .limit(limit);

      return (data as List).map((item) => Transaction.fromMap(item)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Get transactions by type (credit/debit)
  static Future<List<Transaction>> getTransactionsByType(String type) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    try {
      final data = await _supabase
          .from('transactions')
          .select()
          .eq('"user"', user.id)
          .eq('type', type)
          .order('created_at', ascending: false);

      return (data as List).map((item) => Transaction.fromMap(item)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Create a new transaction
  static Future<bool> createTransaction({
    required String type,
    required double amount,
    String? description,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    try {
      await _supabase.from('transactions').insert({
        'user': user.id,
        'type': type,
        'amount': amount,
        'description': description ?? '',
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Transfer money between accounts
  static Future<bool> transferMoney({
    required double amount,
    required int toAccountId,
    String? description,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    try {
      // Start transaction (in real app, use database transaction)

      // 1. Debit from current user
      await createTransaction(
        type: 'debit',
        amount: amount,
        description: description ?? 'Transfer to account $toAccountId',
      );

      // 2. Credit to recipient (in real app, update recipient's account)
      await _supabase.from('transactions').insert({
        'user': user.id, // In real app, this would be recipient's ID
        'type': 'credit',
        'amount': amount,
        'description': 'Transfer from account $toAccountId',
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get recent transactions
  static Future<List<Transaction>> getRecentTransactions([
    int count = 5,
  ]) async {
    final transactions = await getTransactions(limit: count);
    return transactions;
  }
}
