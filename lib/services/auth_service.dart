import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_service.dart';

class AuthService {
  final _supabase = SupabaseService().client;

  Future<AuthResponse> signInWithEmail(String email, String password) =>
      _supabase.auth.signInWithPassword(email: email, password: password);

  Future<AuthResponse> signUpWithEmail(String email, String password) =>
      _supabase.auth.signUp(email: email, password: password);

  Future<void> signInWithOtp(String phone) =>
      _supabase.auth.signInWithOtp(phone: phone);

  Future<AuthResponse> verifyOtp(String phone, String token) =>
      _supabase.auth.verifyOTP(phone: phone, token: token, type: OtpType.sms);

  Future<void> signInWithGoogle() async {
    await _supabase.auth.signInWithOAuth(OAuthProvider.google);
  }

  Future<void> signOut() => _supabase.auth.signOut();

  User? get currentUser => _supabase.auth.currentUser;
}
