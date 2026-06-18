import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../routes.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          Text('OTP sent to ${widget.phone}'),
          TextField(controller: _otpCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'OTP')),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () async {
            await context.read<AuthProvider>().verifyOtp(widget.phone, _otpCtrl.text);
            if (context.read<AuthProvider>().user != null) {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            }
          }, child: const Text('Verify')),
        ]),
      ),
    );
  }
}
