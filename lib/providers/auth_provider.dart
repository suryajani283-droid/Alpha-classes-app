import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();
  User? _user;
  UserModel? _profile;
  bool _loading = false;

  User? get user => _user;
  UserModel? get profile => _profile;
  bool get loading => _loading;

  Future<void> init() async {
    _user = _auth.currentUser;
    if (_user != null) {
      _profile = await _db.getProfile(_user!.id);
    }
    notifyListeners();
  }

  Future<void> loginWithEmail(String email, String password) async {
    _loading = true;
    notifyListeners();
    try {
      await _auth.signInWithEmail(email, password);
      await init();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> loginWithOtp(String phone) async {
    await _auth.signInWithOtp(phone);
  }

  Future<void> verifyOtp(String phone, String token) async {
    _loading = true;
    notifyListeners();
    try {
      await _auth.verifyOtp(phone, token);
      await init();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> loginWithGoogle() async {
    _loading = true;
    notifyListeners();
    try {
      await _auth.signInWithGoogle();
      await init();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    _profile = null;
    notifyListeners();
  }

  Future<void> updateProfile(UserModel profile) async {
    _profile = profile;
    await _db.createProfile(profile);
    notifyListeners();
  }
}
