import 'package:supabase_flutter/supabase_flutter.dart';

/// Bill category model
class BillCategory {
  final String id;
  final String name;
  final String icon;
  final String color;

  const BillCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  static const List<BillCategory> categories = [
    BillCategory(
      id: 'water',
      name: 'Water',
      icon: 'water_drop',
      color: 'lightBlue',
    ),
    BillCategory(
      id: 'electricity',
      name: 'Electricity',
      icon: 'lightbulb',
      color: 'amber',
    ),
    BillCategory(
      id: 'gas',
      name: 'Gas',
      icon: 'local_fire_department',
      color: 'red',
    ),
    BillCategory(
      id: 'shopping',
      name: 'Shopping',
      icon: 'shopping_bag',
      color: 'pink',
    ),
    BillCategory(
      id: 'phone',
      name: 'Phone',
      icon: 'phone_android',
      color: 'blue',
    ),
    BillCategory(
      id: 'credit_card',
      name: 'Credit Card',
      icon: 'credit_card',
      color: 'green',
    ),
    BillCategory(
      id: 'insurance',
      name: 'Insurance',
      icon: 'security',
      color: 'teal',
    ),
    BillCategory(
      id: 'mortgage',
      name: 'Mortgage',
      icon: 'home',
      color: 'purple',
    ),
    BillCategory(
      id: 'other',
      name: 'Other Bills',
      icon: 'receipt_long',
      color: 'grey',
    ),
  ];

  static BillCategory getById(String id) {
    return categories.firstWhere(
      (c) => c.id == id,
      orElse: () => categories[8],
    );
  }
}

/// Bill payment service
class PaymentService {
  static final _supabase = Supabase.instance.client;

  /// Get available bill categories
  static List<BillCategory> getCategories() {
    return BillCategory.categories;
  }

  /// Pay a bill
  static Future<bool> payBill({
    required String category,
    required double amount,
    required String recipient,
    String? description,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    try {
      // Debit from account
      await _supabase.from('transactions').insert({
        'user_id': user.id,
        'type': 'debit',
        'amount': amount,
        'description': description ?? 'Bill payment - $category to $recipient',
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get recent payments
  static Future<List<Map<String, dynamic>>> getRecentPayments([
    int limit = 5,
  ]) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    try {
      final data = await _supabase
          .from('transactions')
          .select()
          .eq('user_id', user.id)
          .eq('type', 'debit')
          .ilike('description', '%Bill payment%')
          .order('created_at', ascending: false)
          .limit(limit);

      return List<Map<String, dynamic>>.from(data as List);
    } catch (e) {
      return [];
    }
  }

  /// Get payment history for a category
  static Future<List<Map<String, dynamic>>> getPaymentsByCategory(
    String category,
  ) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    try {
      final data = await _supabase
          .from('transactions')
          .select()
          .eq('user_id', user.id)
          .eq('type', 'debit')
          .ilike('description', '%$category%')
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(data as List);
    } catch (e) {
      return [];
    }
  }

  /// Validate payment amount
  static String? validateAmount(double amount) {
    if (amount <= 0) {
      return 'Amount must be greater than 0';
    }
    if (amount > 10000) {
      return 'Maximum payment amount is \$10,000';
    }
    return null;
  }

  /// Quick payment presets
  static List<double> getQuickAmounts() {
    return [50, 100, 200, 500, 1000];
  }
}
