import 'package:flutter/material.dart';
import '../services/payment_service.dart';

class PaymentProvider extends ChangeNotifier {
  final PaymentService _payment = PaymentService();
  String? _paymentId;
  bool _paymentSuccess = false;
  bool _processing = false;

  String? get paymentId => _paymentId;
  bool get paymentSuccess => _paymentSuccess;
  bool get processing => _processing;

  void initiatePayment(double amount, String courseName, Function(String) onSuccess) {
    _processing = true;
    notifyListeners();
    _payment.onSuccess = (id) {
      _paymentId = id;
      _paymentSuccess = true;
      _processing = false;
      onSuccess(id);
      notifyListeners();
    };
    _payment.onFailure = () {
      _paymentSuccess = false;
      _processing = false;
      notifyListeners();
    };
    _payment.openCheckout(amount, courseName);
  }
}
