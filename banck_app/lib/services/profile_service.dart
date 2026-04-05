import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Profile service for managing user profiles with custom auth
class ProfileService {
  static final _supabase = Supabase.instance.client;

  /// Login with email and password from profiles table
  static Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = await _supabase
          .from('profiles')
          .select()
          .eq('email', email.toLowerCase())
          .single();

      // Verify password
      final hashedPassword = hashPassword(password);
      if (data['password'] != hashedPassword) {
        return null;
      }

      return data;
    } catch (e) {
      return null;
    }
  }

  /// Hash password using SHA256
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Get current user's profile (by stored user ID)
  static Future<Map<String, dynamic>?> getProfile() async {
    final userId = _getStoredUserId();
    if (userId == null) return null;

    try {
      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      return data;
    } catch (e) {
      return null;
    }
  }

  /// Get profile by ID
  static Future<Map<String, dynamic>?> getProfileById(String id) async {
    try {
      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', id)
          .single();

      return data;
    } catch (e) {
      return null;
    }
  }

  /// Update user profile
  static Future<bool> updateProfile({
    String? name,
    String? bankAccount,
    String? phone,
    String? email,
    String? address,
  }) async {
    final userId = _getStoredUserId();
    if (userId == null) return false;

    try {
      final updates = <String, dynamic>{};
      if (name != null) updates['name'] = name;
      if (bankAccount != null) updates['bank_account'] = bankAccount;
      if (phone != null) updates['phone'] = phone;
      if (email != null) updates['email'] = email.toLowerCase();
      if (address != null) updates['address'] = address;

      await _supabase.from('profiles').update(updates).eq('id', userId);

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Create profile for new user
  static Future<bool> createProfile({
    required String id,
    required String name,
    required String email,
    required String password,
    String? bankAccount,
    String? phone,
    String? address,
  }) async {
    try {
      await _supabase.from('profiles').insert({
        'id': id,
        'name': name,
        'email': email.toLowerCase(),
        'password': hashPassword(password),
        'bank_account': bankAccount,
        'phone': phone,
        'address': address,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Check if email already exists
  static Future<bool> emailExists(String email) async {
    try {
      final data = await _supabase
          .from('profiles')
          .select('id')
          .eq('email', email.toLowerCase())
          .single();
      return data != null;
    } catch (e) {
      return false;
    }
  }

  /// Check if profile exists by ID
  static Future<bool> profileExists() async {
    final userId = _getStoredUserId();
    if (userId == null) return false;

    try {
      final data = await _supabase
          .from('profiles')
          .select('id')
          .eq('id', userId)
          .single();

      return data != null;
    } catch (e) {
      return false;
    }
  }

  /// Store user ID after successful login
  static void storeUserId(String userId) {
    // In a real app, use secure storage
    // For now, we'll use a simple static variable
    _currentUserId = userId;
  }

  /// Clear stored user ID on logout
  static void clearUserId() {
    _currentUserId = null;
  }

  /// Get stored user ID
  static String? _getStoredUserId() {
    return _currentUserId;
  }

  static String? _currentUserId;
}
