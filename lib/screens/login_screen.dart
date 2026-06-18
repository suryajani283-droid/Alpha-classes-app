import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../routes.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  bool _isEmail = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('assets/images/logo.png', height: 80),
            const SizedBox(height: 30),
            ToggleButtons(isSelected: [_isEmail, !_isEmail], onPressed: (i) => setState(() => _isEmail = i == 0),
              children: const [Text('Email'), Text('Mobile')]),
            const SizedBox(height: 20),
            if (_isEmail) ...[
              TextField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
              TextField(controller: _passCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
              ElevatedButton(onPressed: () async {
                await context.read<AuthProvider>().loginWithEmail(_emailCtrl.text, _passCtrl.text);
                if (context.read<AuthProvider>().user != null) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                }
              }, child: const Text('Login')),
            ] else ...[
              TextField(controller: _phoneCtrl, decoration: const InputDecoration(labelText: 'Mobile Number')),
              ElevatedButton(onPressed: () async {
                await context.read<AuthProvider>().loginWithOtp(_phoneCtrl.text);
                Navigator.push(context, MaterialPageRoute(builder: (_) => OtpScreen(phone: _phoneCtrl.text)));
              }, child: const Text('Send OTP')),
            ],
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.g_mobiledata), label: const Text('Google Sign In'),
              onPressed: () async {
                await context.read<AuthProvider>().loginWithGoogle();
                if (context.read<AuthProvider>().user != null) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
